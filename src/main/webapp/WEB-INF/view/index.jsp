<!DOCTYPE html>
<html>
<head>
    <title>IDE</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.45.0/min/vs/loader.min.js"></script>

    <style>
        body {
            margin: 0;
            font-family: Arial;
        }

        /* Top bar */
        #top-bar {
            padding: 10px;
            background: #2d2d2d;
            color: white;
        }

        /* Main layout */
        #container {
            display: flex;
            height: 90vh;
        }

        /* Editor panel */
        #editor {
            width: 60%;
            height: 100%;
        }

        /* Right panel */
        #right-panel {
            width: 40%;
            display: flex;
            flex-direction: column;
        }

        /* Output */
        #output {
            flex: 1;
            border-left: 2px solid #ccc;
            padding: 10px;
            background: #111;
            color: white;
        }

        button {
            margin-left: 10px;
        }
    </style>
</head>

<body>

<div id="top-bar">
    <select id="language">

        <option value="java">Java</option>
        <option value="python">Python</option>
        <option value="c">C</option>
    </select>

    <button onclick="runCode()">Run</button>
</div>

<div id="container">
    <div id="editor"></div>

    <div id="right-panel">
        <textarea id="input" placeholder="Enter input here..." style="width:100%; height:80px;"></textarea>
        <div id="output">Output will appear here...</div>
    </div>
</div>

<script>
    require.config({
        paths: {
            vs: "https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.45.0/min/vs"
        }
    });

    require(["vs/editor/editor.main"], function () {

        window.editor = monaco.editor.create(document.getElementById("editor"), {
            value: `public class Main {
                       public static void main(String[] args) {
                           System.out.println("Hello");
                       }
                   }`,
            language: "java",
            theme: "vs-dark",
            automaticLayout: true
        });

        document.getElementById("language").addEventListener("change", function () {
            let lang = this.value;

            monaco.editor.setModelLanguage(editor.getModel(), lang);

            if (lang === "java") {
                editor.setValue(
        `public class Main {
            public static void main(String[] args) {
                System.out.println("Hello");
            }
        }`);
            } else if (lang === "python") {
                editor.setValue(`print("Hello")`);
            }
            else if (lang === "c") {
                editor.setValue(
            `#include <stdio.h>

            int main() {
                printf("Hello C");
                return 0;
            }`);
            }
        });

    });

    function runCode() {
        let code = editor.getValue();
        let input = document.getElementById("input").value;
        let language = document.getElementById("language").value;

        let formData = new URLSearchParams();
        formData.append("code", code);
        formData.append("input", input);
        formData.append("language", language);

        fetch("run", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: formData
        })
        .then(res => res.text())
        .then(data => {
            document.getElementById("output").innerText = data;
        });
    }
</script>

</body>
</html>
