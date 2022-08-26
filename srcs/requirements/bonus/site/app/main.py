from fastapi import FastAPI, Request
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse

app = FastAPI()
app.mount("/static", StaticFiles(directory="./static", html=True), name="static")

@app.get("/")
async def home(request: Request):
	return FileResponse("static/index.html", media_type="text/html")