package com.ide.encryption;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.KeyGenerator;
import javax.crypto.spec.SecretKeySpec;

import java.io.*;
import java.security.SecureRandom;
import java.util.Arrays;
import java.util.Base64;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

public class SecureCodeUtil {

    private static final String ALGO = "AES/CBC/PKCS5Padding";

    public static SecretKey generateKey() throws Exception {
        KeyGenerator keyGen = KeyGenerator.getInstance("AES");
        keyGen.init(128);
        return keyGen.generateKey();
    }

    private static final byte[] keyBytes = "1234567890123456".getBytes();

    public static SecretKey getFixedKey() {
        return new SecretKeySpec(keyBytes, "AES");
    }

    public static String encryptAndCompress(String code, SecretKey key) throws Exception {

        byte[] compressed = compress(code);

        byte[] iv = new byte[16];
        new SecureRandom().nextBytes(iv);
        IvParameterSpec ivSpec = new IvParameterSpec(iv);

        Cipher cipher = Cipher.getInstance(ALGO);
        cipher.init(Cipher.ENCRYPT_MODE, key, ivSpec);
        byte[] encrypted = cipher.doFinal(compressed);
        
        byte[] combined = new byte[iv.length + encrypted.length];
        System.arraycopy(iv, 0, combined, 0, iv.length);
        System.arraycopy(encrypted, 0, combined, iv.length, encrypted.length);

        return Base64.getEncoder().encodeToString(combined);
    }

    public static String decryptAndDecompress(String encryptedData, SecretKey key) throws Exception {

        byte[] combined = Base64.getDecoder().decode(encryptedData);

        byte[] iv = Arrays.copyOfRange(combined, 0, 16);
        byte[] encrypted = Arrays.copyOfRange(combined, 16, combined.length);

        IvParameterSpec ivSpec = new IvParameterSpec(iv);

        Cipher cipher = Cipher.getInstance(ALGO);
        cipher.init(Cipher.DECRYPT_MODE, key, ivSpec);
        byte[] decrypted = cipher.doFinal(encrypted);


        return decompress(decrypted);
    }

    private static byte[] compress(String data) throws IOException {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        GZIPOutputStream gzip = new GZIPOutputStream(bos);

        gzip.write(data.getBytes());
        gzip.close();

        return bos.toByteArray();
    }

    private static String decompress(byte[] compressed) throws IOException {
        GZIPInputStream gis = new GZIPInputStream(new ByteArrayInputStream(compressed));
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        byte[] buffer = new byte[1024];
        int len;
        while ((len = gis.read(buffer)) > 0) {
            out.write(buffer, 0, len);
        }

        return out.toString();
    }
}
