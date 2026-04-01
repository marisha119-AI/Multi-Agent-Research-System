# 🧠 ResearchMind AI — Multi-Agent Research System

<div align="center">

![ResearchMind AI Banner](https://img.shields.io/badge/ResearchMind-AI-blue?style=for-the-badge&logo=openai&logoColor=white)

**A production-grade Multi-Agent AI System that autonomously researches any topic,
critiques findings, writes a professional report, and generates a PDF — all in one click.**

[![LangGraph](https://img.shields.io/badge/LangGraph-0.1.19-4f46e5?style=flat-square&logo=python&logoColor=white)](https://github.com/langchain-ai/langgraph)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.111-009688?style=flat-square&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![React](https://img.shields.io/badge/React-18-61dafb?style=flat-square&logo=react&logoColor=black)](https://reactjs.org)
[![OpenRouter](https://img.shields.io/badge/OpenRouter-Free_Tier-ff6b35?style=flat-square)](https://openrouter.ai)
[![Python](https://img.shields.io/badge/Python-3.10+-3776ab?style=flat-square&logo=python&logoColor=white)](https://python.org)
[![License](https://img.shields.io/badge/License-MIT-22c55e?style=flat-square)](LICENSE)

[🚀 Quick Start](#-quick-start) • [🏗️ Architecture](#️-system-architecture) • [🤖 Agents](#-the-4-agents) • [📡 API](#-api-endpoints) • [🎤 Interview Guide](#-interview-talking-points)

</div>

---

## ✨ What Is ResearchMind AI?

ResearchMind AI is a **fully autonomous research system** powered by 4 specialized AI agents working in a coordinated pipeline. You give it a topic — it does everything else.

```
You type: "Quantum Computing in 2024"
          ↓
🔍 Research Agent   → Searches web + Wikipedia, gathers facts
🧐 Critic Agent     → Reviews for gaps, accuracy, and balance  
✍️  Writer Agent     → Writes an 800+ word professional report
📄 PDF Generator    → Produces a beautifully formatted PDF
          ↓
You get: A complete research report, ready to download
```

> **Built to demonstrate production-level Agentic AI Engineering skills** — the exact capabilities top MNCs (Google, Microsoft, Accenture, TCS, Infosys AI teams) are hiring for in 2025.

---

## 🎬 Demo

| Start Research | Live Agent Logs | Download PDF |
|---|---|---|
| Type any topic | Watch 4 agents work in real-time | Get a styled PDF report |

**Try these topics:**
- `"Artificial Intelligence in Healthcare"`
- `"Climate Change Solutions 2024"`
- `"How to build AI Agents"`
- `"Quantum Computing breakthroughs"`

---

## 🏗️ System Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                     React Frontend (Port 3000)               │
│   Topic Input → Live Agent Logs → Report Viewer → PDF Download│
└─────────────────────────┬────────────────────────────────────┘
                          │  REST API (FastAPI - Port 8000)
                          ▼
┌──────────────────────────────────────────────────────────────┐
│                   LangGraph Orchestrator                     │
│                                                              │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐      │
│  │  Research   │───▶│   Critic    │───▶│   Writer    │      │
│  │   Agent     │    │   Agent     │    │   Agent     │      │
│  │             │    │             │    │             │      │
│  │ • Web Search│    │ • Gaps      │    │ • 800+ words│      │
│  │ • Wikipedia │    │ • Accuracy  │    │ • Structured│      │
│  │ • Facts     │    │ • Balance   │    │ • Markdown  │      │
│  └─────────────┘    └─────────────┘    └──────┬──────┘      │
│                                               │             │
│                                        ┌──────▼──────┐      │
│                                        │    PDF      │      │
│                                        │  Generator  │      │
│                                        │  ReportLab  │      │
│                                        └─────────────┘      │
└──────────────────────────────────────────────────────────────┘
                          │
                          ▼
                  In-Memory Session Store
          (Agent logs, state, sources, reports)
```

### LangGraph State Machine

```python
class ResearchState(TypedDict):
    session_id: str
    topic: str
    research_notes: str    # ← Research Agent fills this
    critique: str          # ← Critic Agent fills this  
    final_report: str      # ← Writer Agent fills this
    sources: list
    pdf_path: str
    error: str             # ← Triggers conditional early exit

# Pipeline with conditional error edges:
# research ──(ok)──▶ critic ──(ok)──▶ writer ──(ok)──▶ pdf ──▶ END
#          ──(err)──▶ END           ──(err)──▶ END   ──(err)──▶ END
```

---

## 🤖 The 4 Agents

### 🔍 1. Research Agent
**Role:** Information Gatherer

- Runs parallel web searches using **Tavily API** (or DuckDuckGo fallback)
- Fetches structured **Wikipedia summaries**
- Synthesizes raw data into 6 structured sections:
  - Overview, Key Facts & Data, Current Trends, Expert Perspectives, Challenges, Future Outlook
- Collects and stores source URLs for citations

### 🧐 2. Critic Agent
**Role:** Quality Controller

- Reviews research notes on 5 dimensions: **Completeness, Accuracy, Balance, Depth, Structure**
- Flags gaps, unverified claims, and one-sided coverage
- Produces actionable critique that directly improves the final report
- Approves solid sections to pass forward

### ✍️ 3. Writer Agent
**Role:** Report Author

- Consumes research notes **+ critic feedback** together
- Writes a professional 800+ word report in structured markdown
- Addresses every gap identified by the Critic Agent
- Output sections: Executive Summary, Introduction, Key Findings, Trends, Analysis, Challenges, Outlook, Conclusion

### 📄 4. PDF Generator
**Role:** Document Producer

- Converts markdown report into a **beautifully styled PDF** using ReportLab
- Custom typography, headings, source citations, agent badge table
- No external API needed — runs fully local

---

## 📁 Project Structure

```
researchmind-ai/
│
├── backend/
│   ├── main.py                    # FastAPI app — 7 REST endpoints
│   ├── requirements.txt           # Python dependencies
│   ├── .env.example               # Environment variables template
│   │
│   ├── agents/
│   │   ├── orchestrator.py        # ⭐ LangGraph StateGraph pipeline
│   │   ├── research_agent.py      # Agent 1: Research + Tool use
│   │   ├── critic_agent.py        # Agent 2: Quality critique
│   │   ├── writer_agent.py        # Agent 3: Report writing
│   │   └── llm_client.py          # OpenRouter LLM wrapper
│   │
│   ├── tools/
│   │   ├── search.py              # Web search + Wikipedia tools
│   │   └── pdf_generator.py       # ReportLab PDF builder
│   │
│   └── memory/
│       └── store.py               # In-memory session store
│
├── frontend/
│   ├── package.json
│   └── src/
│       ├── index.js
│       └── App.js                 # Full React UI — live logs, report viewer
│
├── reports/                       # Generated PDFs saved here
├── run.sh                         # One-command startup (Linux/Mac)
└── README.md
```

---

## 🚀 Quick Start

### Prerequisites

| Tool | Version | Download |
|---|---|---|
| Python | 3.10+ | [python.org](https://python.org) |
| Node.js | 18+ | [nodejs.org](https://nodejs.org) |
| OpenRouter API Key | Free | [openrouter.ai](https://openrouter.ai) |

### Step 1 — Clone the Repository

```bash
git clone https://github.com/yourusername/researchmind-ai.git
cd researchmind-ai
```

### Step 2 — Setup Backend

```bash
cd backend
pip install -r requirements.txt
cp .env.example .env
```

Edit `.env` and add your OpenRouter API key:
```env
OPENROUTER_API_KEY=your_key_here
CORS_ORIGINS=http://localhost:3000
```

### Step 3 — Start Backend

```bash
# Windows (PowerShell)
cd D:\path\to\researchmind-ai
set PYTHONPATH=D:\path\to\researchmind-ai
uvicorn backend.main:app --reload --port 8000

# Mac / Linux
cd /path/to/researchmind-ai
PYTHONPATH=. uvicorn backend.main:app --reload --port 8000
```

✅ You should see: `Application startup complete.`

### Step 4 — Start Frontend (New Terminal)

```bash
cd frontend
npm install
npm start
```

✅ Browser opens at **http://localhost:3000**

### Step 5 — Test

Open browser → `http://localhost:8000/health`

Should return:
```json
{"status": "ok", "api_key_configured": true}
```

---

## 🔌 API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| `POST` | `/api/research` | Start a new research session |
| `GET` | `/api/session/{id}` | Get session status + live agent logs |
| `GET` | `/api/session/{id}/report` | Get the full markdown report |
| `GET` | `/api/session/{id}/download` | Download PDF report |
| `GET` | `/api/sessions` | List all sessions |
| `DELETE` | `/api/session/{id}` | Delete a session |
| `GET` | `/health` | Health check |

### Example Usage

```bash
# 1. Start research
curl -X POST http://localhost:8000/api/research \
  -H "Content-Type: application/json" \
  -d '{"topic": "Artificial Intelligence in Healthcare"}'

# Response:
# {"session_id": "abc-123", "topic": "...", "status": "created"}

# 2. Poll for live updates
curl http://localhost:8000/api/session/abc-123

# 3. Download PDF when complete
curl http://localhost:8000/api/session/abc-123/download -o report.pdf
```

---

## 🔧 Configuration

### Switching LLM Models

Edit `backend/agents/llm_client.py`:

```python
# Fast free models on OpenRouter:
model="meta-llama/llama-3.2-3b-instruct:free"    # Fastest
model="google/gemma-3-4b-it:free"                 # Good quality
model="arcee-ai/trinity-large-preview:free"        # Large model
model="deepseek/deepseek-r1-0528-qwen3-8b:free"   # Reasoning

# Paid models (much faster):
model="anthropic/claude-3-haiku"
model="openai/gpt-4o-mini"
```

### Adding Tavily Search (Faster Results)

Get a free key at [tavily.com](https://tavily.com) (1000 searches/month free), then add to `.env`:

```env
TAVILY_API_KEY=your_tavily_key_here
```

### Upgrading Memory to Redis

```python
# In backend/agents/orchestrator.py
from langgraph.checkpoint.redis import RedisSaver
checkpointer = RedisSaver.from_conn_string("redis://localhost:6379")
graph = build_graph().compile(checkpointer=checkpointer)
```

---

## 💡 Key Engineering Decisions

| Decision | Rationale |
|---|---|
| **LangGraph over plain LangChain agents** | Explicit state graph = predictable, debuggable, production-safe |
| **OpenRouter instead of OpenAI directly** | Free tier access to 50+ models, easy model switching |
| **FastAPI background tasks** | Non-blocking — UI updates live while agents run in thread pool |
| **In-memory store (Redis-ready)** | Zero-dependency for demo, clean abstraction for easy swap |
| **ReportLab for PDF** | No external API, fully customizable, runs offline |
| **DuckDuckGo fallback** | Works without any API key — demo-ready out of the box |
| **Polling over WebSockets** | Simpler to implement, easier to debug, sufficient for this use case |



---

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|---|---|---|
| Agent Framework | LangGraph 0.1 + LangChain 0.2 | Multi-agent orchestration |
| LLM Provider | OpenRouter API | Free access to 50+ LLMs |
| Backend | FastAPI + Uvicorn | REST API + async task execution |
| Search Tools | Tavily API + DuckDuckGo | Live web search |
| Knowledge | Wikipedia API | Structured knowledge retrieval |
| PDF | ReportLab | Styled PDF generation |
| Frontend | React 18 | Real-time UI with live agent logs |
| Memory | In-memory (Redis-ready) | Session state management |

---

## 📈 Roadmap

- [ ] WebSocket support for real-time push updates
- [ ] Redis persistence for session survival across restarts
- [ ] User authentication with JWT
- [ ] Fact-Checker Agent as 5th pipeline node
- [ ] Smart LLM routing based on task type
- [ ] Export to DOCX, Notion, Google Docs
- [ ] Report quality scoring and evaluation metrics
- [ ] Docker deployment configuration

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/NewAgent`)
3. Commit your changes (`git commit -m 'Add FactChecker Agent'`)
4. Push to the branch (`git push origin feature/NewAgent`)
5. Open a Pull Request

---

## 📄 License

MIT License — free to use for portfolio, learning, and commercial purposes.

---

<div align="center">

**Built with ❤️ to demonstrate Agentic AI Engineering skills**

