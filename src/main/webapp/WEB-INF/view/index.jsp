    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>VM-Code IDE | Workspace</title>
        <!-- Monaco Editor Loader -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.45.0/min/vs/loader.min.js"></script>
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
        <!-- Devicon Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/devicon.min.css">
        <!-- Mobile responsive -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <style>
            :root {
                --bg-dark: #000000;
                --bg-panel: #111111;
                --bg-terminal: #050505;
                --text-primary: #ffffff;
                --text-secondary: #a1a1aa;
                --primary-accent: #a855f7;
                --gradient-button: linear-gradient(135deg, #d8b4fe 0%, #a855f7 100%);
                --border-color: rgba(255, 255, 255, 0.15);
                --header-height: 70px;
                --font-family: 'Outfit', sans-serif;
                --font-mono: 'JetBrains Mono', monospace;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: var(--font-family);
                background: var(--bg-dark);
                color: var(--text-primary);
                height: 100vh;
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }

            /* HEADER / TOP BAR */
            #top-bar {
                height: var(--header-height);
                padding: 0 1.5rem;
                background: rgba(0, 0, 0, 0.8);
                border-bottom: 1px solid var(--border-color);
                display: flex;
                justify-content: space-between;
                align-items: center;
                backdrop-filter: blur(12px);
                z-index: 10;
            }

            .brand {
                display: flex;
                align-items: center;
                gap: 0.8rem;
                text-decoration: none;
                color: var(--text-primary);
                font-weight: 800;
                font-size: 1.5rem;
                cursor: pointer;
            }

            .brand span {
                background: linear-gradient(135deg, #ffffff 0%, #a855f7 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .brand svg {
                width: 24px;
                height: 24px;
                stroke: #d8b4fe;
            }

            .controls {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .lang-select-wrapper {
                position: relative;
                display: flex;
                align-items: center;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid var(--border-color);
                border-radius: 8px;
                padding: 0.3rem 0.8rem;
                transition: all 0.3s ease;
            }

            .lang-select-wrapper:hover {
                border-color: rgba(255,255,255,0.3);
                background: rgba(255, 255, 255, 0.08);
            }

            .lang-select-wrapper i {
                margin-right: 0.5rem;
                font-size: 1.2rem;
            }

            #language {
                appearance: none;
                background: transparent;
                border: none;
                color: var(--text-primary);
                font-family: var(--font-family);
                font-size: 1rem;
                font-weight: 500;
                padding-right: 1.5rem;
                cursor: pointer;
                outline: none;
            }

            #language option {
                background: var(--bg-panel);
                color: var(--text-primary);
            }

            .select-arrow {
                position: absolute;
                right: 0.8rem;
                pointer-events: none;
                color: var(--text-secondary);
            }

            .run-btn {
                background: var(--gradient-button);
                border: none;
                color: white;
                padding: 0.6rem 1.8rem;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: flex;
                align-items: center;
                gap: 0.5rem;
                box-shadow: 0 4px 15px rgba(168, 85, 247, 0.4);
                font-family: var(--font-family);
            }

            .run-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(168, 85, 247, 0.5);
            }

            .run-btn:active {
                transform: translateY(1px);
            }

            .ai-btn {
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid var(--border-color);
                color: var(--text-primary);
                padding: 0.6rem 1.2rem;
                border-radius: 8px;
                font-size: 0.95rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-family: var(--font-family);
            }

            .ai-btn:hover {
                background: rgba(255, 255, 255, 0.1);
                border-color: rgba(255, 255, 255, 0.3);
            }

            .save-btn {
                background: rgba(16, 185, 129, 0.15);
                border: 1px solid rgba(16, 185, 129, 0.4);
                color: #10b981;
                padding: 0.6rem 1.2rem;
                border-radius: 8px;
                font-size: 0.95rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-family: var(--font-family);
            }

            .save-btn:hover {
                background: rgba(16, 185, 129, 0.25);
                border-color: rgba(16, 185, 129, 0.7);
                transform: translateY(-1px);
            }

            .save-btn:active {
                transform: translateY(1px);
            }

            .save-btn.saving {
                opacity: 0.7;
                cursor: not-allowed;
            }

            .exit-btn {
                background: rgba(239, 68, 68, 0.15);
                border: 1px solid rgba(239, 68, 68, 0.4);
                color: #ef4444;
                padding: 0.6rem 1.2rem;
                border-radius: 8px;
                font-size: 0.95rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-family: var(--font-family);
            }

            .exit-btn:hover {
                background: rgba(239, 68, 68, 0.25);
                border-color: rgba(239, 68, 68, 0.7);
                transform: translateY(-1px);
            }

            .exit-btn:active {
                transform: translateY(1px);
            }

            /* MAIN LAYOUT */
            #container {
                display: flex;
                flex: 1;
                height: calc(100vh - var(--header-height));
                overflow: hidden;
                background: #1e1e1e; /* Monaco bg matching */
            }

            #editor {
                width: 60%;
                height: 100%;
                position: relative;
            }

            /* Resize Handle / Splitter (visual only for now without complex JS) */
            .splitter {
                width: 4px;
                background: var(--bg-dark);
                cursor: col-resize;
                border-left: 1px solid var(--border-color);
                border-right: 1px solid var(--border-color);
                z-index: 5;
            }

            #right-panel {
                width: 40%;
                display: flex;
                flex-direction: column;
                background: var(--bg-dark);
                border-left: 1px solid var(--border-color);
            }

            #preview {
                height: 50%;
                width: 100%;
                border: none;
                background: white;
                display: none; /* hidden by default */
            }

            #output-wrapper {
                display: flex;
                flex-direction: column;
                flex: 1;
                height: 100%;
            }

            .output-header {
                background: var(--bg-panel);
                padding: 0.5rem 1rem;
                font-size: 0.85rem;
                font-weight: 600;
                color: var(--text-secondary);
                border-bottom: 1px solid var(--border-color);
                border-top: 1px solid var(--border-color);
                display: flex;
                align-items: center;
                gap: 0.5rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            #output {
                flex: 1;
                padding: 1rem;
                background: var(--bg-terminal);
                color: #10b981; /* Terminal green */
                overflow-y: auto;
                white-space: pre-wrap;
                font-family: var(--font-mono);
                font-size: 0.95rem;
                line-height: 1.5;
                outline: none;
                border: none;
            }

            /* Custom Scrollbar for Terminal */
            #output::-webkit-scrollbar { width: 8px; }
            #output::-webkit-scrollbar-track { background: var(--bg-terminal); }
            #output::-webkit-scrollbar-thumb { background: rgba(255, 255, 255, 0.2); border-radius: 4px; }
            #output::-webkit-scrollbar-thumb:hover { background: rgba(255, 255, 255, 0.3); }

            #preview, #output-wrapper {
                transition: height 0.3s ease;
            }

            /* MOBILE RESPONSIVE TWEAKS */
            @media (max-width: 768px) {
                #top-bar {
                    padding: 0 1rem;
                }
                .brand span {
                    display: none; /* Icon only on mobile */
                }
                #container {
                    flex-direction: column;
                }
                #editor {
                    width: 100%;
                    height: 50%;
                    border-bottom: 1px solid var(--border-color);
                }
                .splitter {
                    display: none;
                }
                #right-panel {
                    width: 100%;
                    height: 50%;
                    border-left: none;
                }
            }

            /* Modal Styles */
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                background: rgba(0, 0, 0, 0.6);
                backdrop-filter: blur(4px);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 1000;
                opacity: 0;
                pointer-events: none;
                transition: opacity 0.3s ease;
            }

            .modal-overlay.active {
                opacity: 1;
                pointer-events: auto;
            }

            .modal-content {
                background: var(--bg-panel);
                border: 1px solid var(--border-color);
                border-radius: 12px;
                width: 90%;
                max-width: 400px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5);
                transform: translateY(20px);
                transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                overflow: hidden;
            }

            .modal-overlay.active .modal-content {
                transform: translateY(0);
            }

            .modal-header {
                padding: 1.2rem 1.5rem;
                border-bottom: 1px solid var(--border-color);
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .modal-header h3 {
                font-size: 1.1rem;
                font-weight: 600;
                color: var(--text-primary);
            }

            .close-btn {
                background: none;
                border: none;
                color: var(--text-secondary);
                cursor: pointer;
                transition: color 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 4px;
                border-radius: 4px;
            }

            .close-btn:hover {
                color: var(--text-primary);
                background: rgba(255, 255, 255, 0.05);
            }

            .modal-body {
                padding: 1.5rem;
            }

            .modal-body p {
                color: var(--text-secondary);
                font-size: 0.95rem;
                margin-bottom: 1rem;
            }

            #save-title-input {
                width: 100%;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid var(--border-color);
                color: var(--text-primary);
                padding: 0.8rem 1rem;
                border-radius: 8px;
                font-family: var(--font-family);
                font-size: 1rem;
                outline: none;
                transition: border-color 0.3s ease;
            }

            #save-title-input:focus {
                border-color: var(--primary-accent);
                background: rgba(255, 255, 255, 0.08);
            }

            .modal-footer {
                padding: 1rem 1.5rem;
                background: rgba(0, 0, 0, 0.2);
                border-top: 1px solid var(--border-color);
                display: flex;
                justify-content: flex-end;
                gap: 1rem;
            }

            .btn-cancel {
                background: transparent;
                border: 1px solid var(--border-color);
                color: var(--text-primary);
                padding: 0.6rem 1.2rem;
                border-radius: 8px;
                font-size: 0.95rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                font-family: var(--font-family);
            }

            .btn-cancel:hover {
                background: rgba(255, 255, 255, 0.05);
                border-color: rgba(255, 255, 255, 0.3);
            }

            .btn-confirm {
                background: var(--gradient-button);
                border: none;
                color: white;
                padding: 0.6rem 1.2rem;
                border-radius: 8px;
                font-size: 0.95rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                font-family: var(--font-family);
                box-shadow: 0 4px 15px rgba(168, 85, 247, 0.3);
            }

            .btn-confirm:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(168, 85, 247, 0.4);
            }

            /* History Details */
            .history-item {
                padding: 1rem;
                border-bottom: 1px solid var(--border-color);
                cursor: pointer;
                transition: background 0.3s ease;
                display: flex;
                justify-content: space-between;
                align-items: center;
                text-align: left;
            }

            .history-item:hover {
                background: rgba(255, 255, 255, 0.05);
                border-radius: 8px;
            }

            .history-item:last-child {
                border-bottom: none;
            }

            .history-item-title {
                font-weight: 600;
                color: var(--primary-accent);
                margin-bottom: 0.3rem;
                font-size: 1.05rem;
                text-decoration: underline;
            }

            .history-item-meta {
                font-size: 0.85rem;
                color: var(--text-secondary);
            }
        </style>
    </head>

    <body>

    <div id="top-bar">
        <a href="/VM-code/" class="brand" title="Go Home">
            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <polyline points="16 18 22 12 16 6"></polyline>
                <polyline points="8 6 2 12 8 18"></polyline>
            </svg>
            <span>VM Code</span>
        </a>

        <div class="controls">
            <div class="lang-select-wrapper">
                <i id="lang-icon" class="devicon-java-plain colored"></i>
                <select id="language">
                    <option value="java">Java</option>
                    <option value="python">Python</option>
                    <option value="c">C</option>
                    <option value="html">UI ENGINE</option>
                    <option value="mysql">MySQL</option>
                </select>
                <svg class="select-arrow" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
            </div>

            <button class="ai-btn" onclick="explainCode()" title="Explain Code">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="10"></circle>
                    <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
                    <line x1="12" y1="17" x2="12.01" y2="17"></line>
                </svg>
                Explain
            </button>

            <button class="ai-btn" onclick="debugCodeAI()" title="Debug Code">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M12 2v20M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                </svg>
                Debug
            </button>

            <button class="ai-btn" onclick="openHistoryModal()" title="View Code History">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path>
                        </svg>
                        File
            </button>

            <button id="save-btn" class="save-btn" onclick="saveCode()" title="Save Code">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path>
                    <polyline points="17 21 17 13 7 13 7 21"></polyline>
                    <polyline points="7 3 7 8 15 8"></polyline>
                </svg>
                Save
            </button>

            <button class="run-btn" onclick="runCode()">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <polygon points="5 3 19 12 5 21 5 3" fill="currentColor"></polygon>
                </svg>
                Run
            </button>

            <button class="exit-btn"
            onclick="window.location.href='/VM-code/logout'"
            title="Exit to Login">
            Exit
            </button>
        </div>
    </div>

    <div id="container">
        <div id="editor"></div>

        <div class="splitter"></div>

        <div id="right-panel">
            <iframe id="preview"></iframe>
            <div id="output-wrapper">
                <div class="output-header">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="4 17 10 11 4 5"></polyline><line x1="12" y1="19" x2="20" y2="19"></line></svg>
                    Terminal Output
                </div>
                <div id="output" contenteditable="true"></div>
            </div>
        </div>
    </div>

    <!-- Save Code Modal -->
    <div id="save-modal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Save Code Snippet</h3>
                <button class="close-btn" onclick="closeSaveModal()">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="18" y1="6" x2="6" y2="18"></line>
                        <line x1="6" y1="6" x2="18" y2="18"></line>
                    </svg>
                </button>
            </div>
            <div class="modal-body">
                <p>Enter a title for your code to save it to your history.</p>
                <input type="text" id="save-title-input" placeholder="e.g., My Awesome Algorithm" autocomplete="off" onkeydown="if(event.key === 'Enter') confirmSaveCode()">
            </div>
            <div class="modal-footer">
                <button class="btn-cancel" onclick="closeSaveModal()">Cancel</button>
                <button class="btn-confirm" onclick="confirmSaveCode()">Save Snippet</button>
            </div>
        </div>
    </div>

    <!-- History Modal -->
    <div id="history-modal" class="modal-overlay">
        <div class="modal-content" style="max-width: 600px; max-height: 80vh; display: flex; flex-direction: column;">
            <div class="modal-header">
                <h3>Your Saved Code Snippets</h3>
                <button class="close-btn" onclick="closeHistoryModal()">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="18" y1="6" x2="6" y2="18"></line>
                        <line x1="6" y1="6" x2="18" y2="18"></line>
                    </svg>
                </button>
            </div>
            <div class="modal-body" style="overflow-y: auto; flex: 1; padding: 0.5rem;">
                <ul id="history-list" style="list-style: none; margin: 0; padding: 0;">
                </ul>
            </div>
        </div>
    </div>

    <script>
    let socket;
    let outputBox = document.getElementById("output");
    let outputText = "";
    let currentInput = "";
    let langIcon = document.getElementById("lang-icon");

    const iconsMap = {
        java: "devicon-java-plain colored",
        python: "devicon-python-plain colored",
        c: "devicon-c-plain colored",
        cpp: "devicon-cplusplus-plain colored",
        html: "devicon-html5-plain colored",
        mysql: "devicon-mysql-plain colored"
    };

    const templates = {
        java: `import java.util.*; \n public class Main {\n    public static void main(String[] args) {\n        System.out.println("Enter numbers:");\n        Scanner sc = new Scanner(System.in);\n        int a = sc.nextInt();\n        int b = sc.nextInt();\n        System.out.println("Result: " + (a + b));\n    }\n}`,
        python: `print("Enter numbers:")\na = int(input())\nb = int(input())\nprint(f"Result: {a + b}")`,
        c: `#include <stdio.h>\n\nint main() {\n    int a, b;\n    printf("Enter numbers:\\n");\n  scanf("%d %d", &a, &b);\n    printf("Result: %d\\n", a + b);\n    return 0;\n}`,
        html: `<!DOCTYPE html>\n<html>\n<head>\n<style>\n h1 { color: #3b82f6; }\n</style>\n</head>\n<body>\n\n<h1>Hello VM Code IDE </h1>\n<script>\nconsole.log("JS is working!");\n<\/script>\n\n</body>\n</html>`,
        mysql: `CREATE TABLE intern (
    id INT PRIMARY KEY,
    name VARCHAR(50)
    );

    INSERT INTO intern VALUES (1, 'Madhan');
    INSERT INTO intern VALUES (2, 'Vignesh');

    SELECT * FROM intern;`
};

    function appendOutput(text) {
        outputText += text + "\n";
        render();
    }
    function render() {
        outputBox.innerText = outputText + currentInput;
        moveCursorToEnd();
    }
    function moveCursorToEnd() {
        outputBox.focus();
        let range = document.createRange();
        range.selectNodeContents(outputBox);
        range.collapse(false);
        let sel = window.getSelection();
        sel.removeAllRanges();
        sel.addRange(range);
    }

    function clearOutput() {
        outputText = "";
        outputBox.innerText = "";
    }

    function setLayout(language) {
        const preview = document.getElementById("preview");
        const outputWrapper = document.getElementById("output-wrapper");

        // Update icon
        langIcon.className = iconsMap[language] || "devicon-code-plain";

        if (language === "html") {
            preview.style.display = "block";
            preview.style.height = "55%";
            outputWrapper.style.height = "45%";
        } else {
            preview.style.display = "none";
            outputWrapper.style.height = "100%";
        }
    }

    function runCode() {
        clearOutput();

        let code = editor.getValue();
        let language = document.getElementById("language").value;
        setLayout(language);

        if (language === "html") {
            let iframe = document.getElementById("preview");
             let injectedScript = `
            <script>
            (function() {
                const send = (type, msg) => {
                    parent.postMessage({type, msg}, "*");
                };

                console.log = (...args) => send("log", args.join(" "));
                console.error = (...args) => send("error", args.join(" "));
                console.warn = (...args) => send("warn", args.join(" "));
            })();
            <\/script>
            `;
            let finalCode = injectedScript + code;
            iframe.srcdoc = finalCode;
            return;
        }

        socket = new WebSocket("ws://localhost:8080/VM-code/ws");
        appendOutput(language === "mysql" ? "[Executing SQL...]" : "[Connecting to server...]");

        socket.onopen = function () {
            if (language !== "mysql") {
                appendOutput("[Running code...]");
            }

            socket.send(JSON.stringify({
                action: "run",
                language: language,
                code: code
            }));
        };

        socket.onmessage = function (event) {
            appendOutput(event.data);
        };

        socket.onerror = function() {
            appendOutput("[Connection error]");
        };

        socket.onclose = function() {
            if (language !== "mysql") {
                appendOutput("[Process finished]");
            }
        };
    }

    function updateTerminal(text) {
        clearOutput();
        appendOutput(text);
    }

    async function explainCode() {
        const code = editor.getValue();

        updateTerminal("[Asking AI to explain code...]");
        try {
            const res = await fetch("/VM-code/ai/explain", {
                method: "POST",
                headers: {
                    "Content-Type": "text/plain"
                },
                body: code
            });
            const text = await res.text();
            updateTerminal(text);
        } catch (err) {
            updateTerminal("Error: " + err.message);
        }
    }
    async function debugCodeAI() {
        const code = editor.getValue();
        updateTerminal("[Asking AI to debug code...]");
        try {
            const res = await fetch("/VM-code/ai/debug", {
                method: "POST",
                headers: {
                    "Content-Type": "text/plain"
                },
                body: code
            });
            const text = await res.text();
            updateTerminal(text);
        } catch (err) {
            updateTerminal("Error: " + err.message);
        }
    }
    function saveCode() {
        const modal = document.getElementById('save-modal');
        const input = document.getElementById('save-title-input');
        input.value = '';
        modal.classList.add('active');
        setTimeout(() => input.focus(), 100);
    }

    function closeSaveModal() {
        const modal = document.getElementById('save-modal');
        modal.classList.remove('active');
    }

    async function confirmSaveCode() {
        const titleInput = document.getElementById('save-title-input');
        let title = titleInput.value;

        if (!title || !title.trim()) {
            updateTerminal("Save cancelled (no title provided)");
            closeSaveModal();
            return;
        }
        closeSaveModal();
        const code     = editor.getValue();
        const language = document.getElementById("language").value;
        const output   = outputText.trim();
        try {
            const res = await fetch("/VM-code/api/save", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ title, language, code, output })
            });
            const text = await res.text();
            updateTerminal(text);
        } catch (err) {
            updateTerminal("Save error: " + err.message);
        }
    }
    let loadedHistory = [];
    async function openHistoryModal() {
        const modal = document.getElementById('history-modal');
        const list = document.getElementById('history-list');
        list.innerHTML = '<li style="text-align:center; padding: 2rem; color: var(--text-secondary);">Loading...</li>';
        modal.classList.add('active');

        try {
            const res = await fetch('/VM-code/api/history');
            if (!res.ok) throw new Error('Failed to fetch history');
            const data = await res.json();
            loadedHistory = data;

            if (data.length === 0) {
                list.innerHTML = '<li style="text-align:center; padding: 2rem; color: var(--text-secondary);">No history found</li>';
                return;
            }

            list.innerHTML = '';
            data.forEach((item, index) => {
                const li = document.createElement('li');
                li.className = 'history-item';
                li.onclick = () => loadHistoryItem(index);

                const date = item.createdAt ? new Date(item.createdAt).toLocaleString() : 'Date N/A';
                const title = item.title || 'Untitled Snippet';
                const language = item.language || 'Unknown';

                li.innerHTML = `
                    <div>
                        <div class="history-item-title">\${title}</div>
                        <div class="history-item-meta">\${language} | \${date}</div>
                    </div>
                `;
                list.appendChild(li);
            });
        } catch (err) {
            list.innerHTML = '<li style="text-align:center; padding: 2rem; color: #ef4444;">Error loading history</li>';
        }
    }

    function closeHistoryModal() {
        document.getElementById('history-modal').classList.remove('active');
    }

    function loadHistoryItem(index) {
        const item = loadedHistory[index];

        let selectBox = document.getElementById("language");
        selectBox.value = item.language;
        let monacoLang = item.language === "html" ? "html" : item.language === "c" || item.language === "cpp" ? "c" : item.language;
        if(item.language === "cpp") monacoLang = "cpp";

        monaco.editor.setModelLanguage(editor.getModel(), monacoLang);
        editor.setValue(item.code);

        if (item.output) {
            updateTerminal(item.output);
        } else {
            clearOutput();
        }
        setLayout(item.language);

        closeHistoryModal();
    }

    window.addEventListener("message", function (event) {
        if (!event.data) return;
        if (event.data.type === "log") {
            appendOutput("> " + event.data.msg);
        }
        if (event.data.type === "error") {
            appendOutput("[Error] " + event.data.msg);
        }
    });

    require.config({
        paths: {
            vs: "https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.45.0/min/vs"
        }
    });

    require(["vs/editor/editor.main"], function () {

        window.editor = monaco.editor.create(document.getElementById("editor"), {
            value: templates["java"],
            language: "java",
            theme: "vs-dark",
            automaticLayout: true,
            fontSize: 14,
            fontFamily: "'JetBrains Mono', monospace",
            minimap: { enabled: false },
            scrollBeyondLastLine: false,
            roundedSelection: true,
            padding: { top: 16 }
        });

        document.getElementById("language").addEventListener("change", function () {
            let lang = this.value;
            let monacoLang = lang === "html" ? "html" : lang === "c" || lang === "cpp" ? "c" : lang;

            if(lang === "cpp") monacoLang = "cpp";

            monaco.editor.setModelLanguage(editor.getModel(), monacoLang);
            editor.setValue(templates[lang] || "");

            document.getElementById("preview").srcdoc = "";
            clearOutput();
            setLayout(lang);
        });

    });

    outputBox.addEventListener("keydown", function (e) {
        if (!socket || socket.readyState !== WebSocket.OPEN) return;
        if (e.key === "Enter") {
            e.preventDefault();
            socket.send(currentInput);
            outputText += currentInput + "\n";
            currentInput = "";
        }
        else if (e.key === "Backspace") {
            if(currentInput.length > 0) {
                currentInput = currentInput.slice(0, -1);
                e.preventDefault();
            }
        }
        else if (e.key.length === 1 && !e.ctrlKey && !e.metaKey) {
            currentInput += e.key;
            e.preventDefault();
        }
        render();
    });

    window.onload = function () {
        const params = new URLSearchParams(window.location.search);
        const lang = params.get("lang") || "java";

        let selectBox = document.getElementById("language");

        if(Array.from(selectBox.options).some(opt => opt.value === lang)) {
            selectBox.value = lang;
        } else {
            selectBox.value = "java";
        }

        if (window.editor && templates[selectBox.value]) {
            let monacoLang = selectBox.value === "html" ? "html" : selectBox.value === "c" || selectBox.value === "cpp" ? "c" : selectBox.value;
            if(selectBox.value === "cpp") monacoLang = "cpp";
            monaco.editor.setModelLanguage(window.editor.getModel(), monacoLang);
            window.editor.setValue(templates[selectBox.value]);
        }

        setLayout(selectBox.value);
    };
    </script>

    </body>
    </html>