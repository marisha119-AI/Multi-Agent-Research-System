# 🧠 ResearchMind AI — Multi-Agent Research System

> **A production-grade agentic AI system** that autonomously researches any topic using a pipeline of specialized AI agents, built with LangGraph, FastAPI, and React.

[![LangGraph](https://img.shields.io/badge/LangGraph-0.1.19-blue?style=flat-square)](https://github.com/langchain-ai/langgraph)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.111-green?style=flat-square)](https://fastapi.tiangolo.com)
[![React](https://img.shields.io/badge/React-18-61dafb?style=flat-square)](https://reactjs.org)
[![OpenRouter](https://img.shields.io/badge/LLM-OpenRouter-orange?style=flat-square)](https://openrouter.ai)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)](LICENSE)

---

## 🎯 What This Project Demonstrates

This project was built to demonstrate **production-level agentic AI engineering** skills required at top MNCs (Accenture, TCS, Infosys, Google, Microsoft, Amazon AI teams, etc.).

| Skill | How It's Demonstrated |
|---|---|
| **Multi-Agent Orchestration** | 4 specialized agents with defined roles, coordinated by LangGraph StateGraph |
| **Tool Use / Function Calling** | Web search (Tavily/DuckDuckGo), Wikipedia API, PDF generation |
| **Memory & State Management** | In-memory session store with full agent state across pipeline steps |
| **Real-World API Integration** | OpenRouter LLM API, Tavily Search API, Wikipedia API |
| **Graph-based Agent Flow** | Conditional edges, error handling, node-by-node state transitions |
| **Production Backend** | FastAPI with async background tasks, REST API, CORS, file serving |
| **Modern Frontend** | React 18 with real-time polling, live agent logs, report viewer |

---

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    USER (React Frontend)                 │
│         Types topic → Watches live agent logs           │
│         Views report → Downloads PDF                    │
└────────────────────┬────────────────────────────────────┘
                     │ REST API (FastAPI)
                     ▼
┌─────────────────────────────────────────────────────────┐
│                  LANGGRAPH ORCHESTRATOR                  │
│                                                         │
│   ┌─────────────┐    ┌─────────────┐                   │
│   │  Research   │───▶│   Critic    │                   │
│   │   Agent     │    │   Agent     │                   │
│   │             │    │             │                   │
│   │ Tools:      │    │ Evaluates:  │                   │
│   │ • Web Search│    │ • Gaps      │                   │
│   │ • Wikipedia │    │ • Accuracy  │                   │
│   └─────────────┘    │ • Balance   │                   │
│                      └──────┬──────┘                   │
│                             │                           │
│                      ┌──────▼──────┐                   │
│                      │   Writer    │                   │
│                      │   Agent     │                   │
│                      │             │                   │
│                      │ Produces:   │                   │
│                      │ • Full report│                  │
│                      │ • Sections  │                   │
│                      └──────┬──────┘                   │
│                             │                           │
│                      ┌──────▼──────┐                   │
│                      │    PDF      │                   │
│                      │  Generator  │                   │
│                      │             │                   │
│                      │ ReportLab   │                   │
│                      │ Styled PDF  │                   │
│                      └─────────────┘                   │
└─────────────────────────────────────────────────────────┘
                     │
                     ▼
              In-Memory Store
         (Session state, agent logs,
          research notes, sources)
```

---

## 🤖 The 4 Agents

### 1. 🔍 Research Agent
- Runs **parallel web searches** using Tavily or DuckDuckGo
- Fetches structured Wikipedia summaries
- Synthesizes raw data into structured research notes
- Covers: Overview, Key Facts, Trends, Expert Views, Challenges, Outlook

### 2. 🧐 Critic Agent
- Reviews research notes for **completeness, accuracy, balance, and depth**
- Flags gaps and unverified claims
- Produces actionable critique that improves final report quality
- Approves solid sections to pass forward

### 3. ✍️ Writer Agent
- Consumes research notes **+ critic feedback**
- Writes a professional 800+ word report in structured markdown
- Addresses every gap flagged by the Critic Agent
- Sections: Executive Summary, Introduction, Key Findings, Trends, Analysis, Challenges, Outlook, Conclusion

### 4. 📄 PDF Generator
- Converts the markdown report into a **beautifully formatted PDF**
- Custom styles: headings, body text, source citations, agent badges
- Built with ReportLab — no external services needed

---

## 📁 Project Structure

```
researchmind-ai/
├── backend/
│   ├── main.py                    # FastAPI application + all routes
│   ├── requirements.txt
│   ├── .env.example
│   ├── agents/
│   │   ├── orchestrator.py        # LangGraph StateGraph pipeline
│   │   ├── research_agent.py      # Agent 1: Research
│   │   ├── critic_agent.py        # Agent 2: Critique
│   │   ├── writer_agent.py        # Agent 3: Write
│   │   └── llm_client.py          # OpenRouter LLM wrapper
│   ├── tools/
│   │   ├── search.py              # Web search + Wikipedia tools
│   │   └── pdf_generator.py       # ReportLab PDF builder
│   └── memory/
│       └── store.py               # In-memory session store
├── frontend/
│   ├── package.json
│   ├── public/index.html
│   └── src/
│       ├── index.js
│       └── App.js                 # Full React UI
├── reports/                       # Generated PDFs saved here
├── run.sh                         # One-command startup script
└── README.md
```

---

## 🚀 Quick Start

### Prerequisites
- Python 3.10+
- Node.js 18+
- OpenRouter API key (free at [openrouter.ai](https://openrouter.ai))

### 1. Clone & Setup Backend

```bash
git clone https://github.com/yourusername/researchmind-ai
cd researchmind-ai/backend

# Create virtual environment
python -m venv venv
source venv/bin/activate        # Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Configure environment
cp .env.example .env
# Edit .env and add your OPENROUTER_API_KEY
```

### 2. Start Backend

```bash
# From backend/ directory (with venv active)
cd ..
uvicorn backend.main:app --reload --port 8000
```

API docs available at: `http://localhost:8000/docs`

### 3. Setup & Start Frontend

```bash
cd frontend
npm install
npm start
```

Frontend at: `http://localhost:3000`

### One-Command Start (after setup)

```bash
bash run.sh
```

---

## 🔌 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/research` | Start a new research session |
| `GET` | `/api/session/{id}` | Get session status + agent logs |
| `GET` | `/api/session/{id}/report` | Get the full markdown report |
| `GET` | `/api/session/{id}/download` | Download PDF report |
| `GET` | `/api/sessions` | List all sessions |
| `DELETE` | `/api/session/{id}` | Delete a session |
| `GET` | `/health` | Health check |

### Example API Usage

```bash
# Start research
curl -X POST http://localhost:8000/api/research \
  -H "Content-Type: application/json" \
  -d '{"topic": "Artificial Intelligence in Healthcare"}'

# Response: {"session_id": "abc-123", "topic": "...", "status": "created"}

# Poll for updates
curl http://localhost:8000/api/session/abc-123

# Download PDF
curl http://localhost:8000/api/session/abc-123/download -o report.pdf
```

---

## 🧠 LangGraph State Flow

```python
# The agent pipeline is a typed state machine
class ResearchState(TypedDict):
    session_id: str
    topic: str
    research_notes: str    # Populated by Research Agent
    critique: str          # Populated by Critic Agent
    final_report: str      # Populated by Writer Agent
    sources: list
    pdf_path: str
    error: str             # Triggers early exit via conditional edge

# Graph edges:
# research ──(ok)──▶ critic ──(ok)──▶ writer ──(ok)──▶ pdf ──▶ END
#          ──(err)──▶ END            ──(err)──▶ END   ──(err)──▶ END
```

---

## 💡 Key Engineering Decisions

| Decision | Why |
|---|---|
| **LangGraph over LangChain Agents** | Explicit state graph = predictable, debuggable, production-safe |
| **OpenRouter (not OpenAI directly)** | Free tier access to 50+ models; easy model switching |
| **FastAPI background tasks** | Non-blocking — UI updates while agents run in parallel thread |
| **In-memory store** | Zero-dependency for demo; easily swappable to Redis/PostgreSQL |
| **ReportLab for PDF** | No external API needed; fully customizable styling |
| **DuckDuckGo fallback** | Works without any API key — demo-ready out of the box |

---

## 🔧 Extending the System

### Add a new agent node

```python
# In backend/agents/orchestrator.py

def fact_check_node(state: ResearchState) -> ResearchState:
    # Your new agent logic
    return {**state, "fact_check_result": "..."}

graph.add_node("fact_check", fact_check_node)
graph.add_edge("critic", "fact_check")
graph.add_edge("fact_check", "writer")
```

### Switch to a different LLM

```python
# In backend/agents/llm_client.py
model="anthropic/claude-3-haiku"        # Claude
model="google/gemma-7b-it:free"         # Gemma (free)
model="meta-llama/llama-3-8b-instruct:free"  # LLaMA 3 (free)
```

### Add Redis memory persistence

```python
# Replace InMemoryStore with:
from langgraph.checkpoint.redis import RedisSaver
checkpointer = RedisSaver.from_conn_string("redis://localhost:6379")
graph = build_graph().compile(checkpointer=checkpointer)
```

---

## 🎤 Interview Talking Points

**"Tell me about your agentic AI project"**

> "I built ResearchMind AI — a multi-agent research system where four specialized agents collaborate to produce a full PDF research report on any topic. I used LangGraph to define the pipeline as a state machine with typed state transitions and conditional error edges. The Research Agent uses web search and Wikipedia tools, the Critic Agent validates quality, the Writer Agent produces structured markdown, and a PDF Generator handles the final output. The backend is FastAPI with async task execution, and the frontend is React with real-time polling to show live agent activity. The whole system runs on OpenRouter's free tier so it's demo-ready without any cost."

**"Why LangGraph instead of plain LangChain agents?"**

> "LangGraph gives you explicit control over the agent flow as a directed graph. With standard ReAct agents, the model decides when to stop, which is unpredictable in production. With LangGraph, I define exactly which agent runs when, what state gets passed, and what happens on errors. That makes it easier to debug, test, and extend — which matters a lot in enterprise environments."

**"How does your memory system work?"**

> "Right now it's an in-memory session store — a simple dictionary keyed by session ID, holding agent messages, research notes, critique, and the final report. It's designed to be swappable — you can plug in Redis with LangGraph's built-in checkpointer, or PostgreSQL for persistence. The session abstraction means the frontend can poll for updates without any websocket complexity."

---

## 📈 Roadmap (Future Enhancements)

- [ ] **WebSocket support** — replace polling with real-time push
- [ ] **Redis persistence** — sessions survive server restarts
- [ ] **User authentication** — multi-user support with JWT
- [ ] **More agents** — Fact-Checker Agent, Citation Formatter Agent
- [ ] **LLM routing** — smart model selection based on task type
- [ ] **Export formats** — DOCX, Notion, Google Docs
- [ ] **Evaluation metrics** — report quality scoring

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **Agent Framework** | LangGraph 0.1, LangChain 0.2 |
| **LLM Provider** | OpenRouter (Mistral 7B free tier) |
| **Backend** | FastAPI, Uvicorn, Pydantic |
| **Search Tools** | Tavily API, DuckDuckGo Search, Wikipedia |
| **PDF Generation** | ReportLab |
| **Frontend** | React 18, vanilla CSS |
| **Memory** | In-memory (Redis-ready) |

---

## 👨‍💻 Author

Built as a portfolio project to demonstrate **agentic AI engineering** skills for MNC roles.

- **Skills showcased**: Multi-agent orchestration, LangGraph, tool use, FastAPI, React, API integration
- **Target roles**: Agentic AI Developer, AI Engineer, LLM Engineer, ML Engineer

---

## 📄 License

MIT License — free to use for portfolio and learning purposes.
