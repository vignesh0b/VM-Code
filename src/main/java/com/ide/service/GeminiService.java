package com.ide.service;

import okhttp3.*;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

@Service
public class GeminiService {

    private String apiKey;
    private OkHttpClient httpClient;

    public GeminiService(@Value("${gemini.api.key}") String key) {
        this.apiKey = key;
        this.httpClient = new OkHttpClient.Builder()
                .connectTimeout(90, TimeUnit.SECONDS)
                .readTimeout(90, TimeUnit.SECONDS)
                .build();
    }
    private String callGemini(String prompt) {

        String apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=" + apiKey;

        try {
            JSONObject bodyJson = new JSONObject();
            JSONArray contentsArr = new JSONArray();
            JSONObject contentObj = new JSONObject();
            JSONArray partsArr = new JSONArray();
            JSONObject textObj = new JSONObject();
            textObj.put("text", prompt);

            partsArr.put(textObj);
            contentObj.put("parts", partsArr);
            contentsArr.put(contentObj);

            bodyJson.put("contents", contentsArr);

            RequestBody requestBody = RequestBody.create(
                    bodyJson.toString(),
                    MediaType.parse("application/json")
            );

            Request request = new Request.Builder()
                    .url(apiUrl)
                    .post(requestBody)
                    .build();

            Response response = httpClient.newCall(request).execute();

            if (response.body() == null) {
                return "No response from Gemini API";
            }

            String responseStr = response.body().string();
            JSONObject json = new JSONObject(responseStr);

            if (json.has("error")) {
                JSONObject err = json.getJSONObject("error");
                return "API Error: " + err.optString("message");
            }
            JSONArray candidates = json.optJSONArray("candidates");
            if (candidates == null || candidates.length() == 0) {
                return "No output generated";
            }

            JSONObject first = candidates.getJSONObject(0);
            JSONObject content = first.optJSONObject("content");
            if (content == null) return "Invalid response";

            JSONArray parts = content.optJSONArray("parts");
            if (parts == null || parts.length() == 0) {
                return "Empty result";
            }

            return parts.getJSONObject(0).optString("text", "No text found");

        } catch (IOException e) {
            return "Network issue: " + e.getMessage();
        } catch (Exception e) {
            return "Unexpected error: " + e.getMessage();
        }
    }

    public String explainCode(String code) {
        return callGemini("Explain this code in simple terms also at last give code complixity:\n" + code);
    }
    public String debugCode(String code) {
        return callGemini("Find and fix issues in this code:\n" + code);
    }

}