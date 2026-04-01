#!/bin/bash
# ResearchMind AI — One-command startup script

echo "🧠 Starting ResearchMind AI..."
echo ""

# Check .env exists
if [ ! -f "backend/.env" ]; then
  echo "⚠️  No .env found. Copying from .env.example..."
  cp backend/.env.example backend/.env
  echo "👉 Please edit backend/.env and add your OPENROUTER_API_KEY"
  echo ""
fi

# Start backend in background
echo "🚀 Starting FastAPI backend on port 8000..."
cd backend
source venv/bin/activate 2>/dev/null || python -m venv venv && source venv/bin/activate
pip install -r requirements.txt -q
uvicorn main:app --reload --port 8000 &
BACKEND_PID=$!
cd ..

# Wait for backend to start
sleep 3

# Start frontend
echo "⚛️  Starting React frontend on port 3000..."
cd frontend
npm install -q
npm start &
FRONTEND_PID=$!
cd ..

echo ""
echo "✅ ResearchMind AI is running!"
echo "   Frontend:  http://localhost:3000"
echo "   API Docs:  http://localhost:8000/docs"
echo ""
echo "Press Ctrl+C to stop both servers."

# Handle Ctrl+C
trap "echo ''; echo 'Shutting down...'; kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; exit 0" INT
wait
