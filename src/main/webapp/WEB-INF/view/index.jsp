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
        <option value="javascript">JavaScript</option>
        <option value="java">Java</option>
    </select>

    <button onclick="runCode()">Run</button>
</div>

<div id="container">
    <div id="editor"></div>

    <div id="right-panel">
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
            value: "// Write your code here",
            language: "java",
            theme: "vs-dark",
            automaticLayout: true
        });


    });

    function runCode() {
        let code = editor.getValue();

        document.getElementById("output").innerText =
            "Output:\n\n" + code;
    }
</script>

</body>
</html>
