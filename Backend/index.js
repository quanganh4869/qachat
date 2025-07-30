const express = require("express");
const http = require("http");
const cors = require("cors");

const app = express();
const port = process.env.PORT || 5000;

app.use(express.json());
app.use(cors()); // Cho phép API REST

const server = http.createServer(app);

// ✅ Cấu hình Socket.IO
const io = require("socket.io")(server, {
  cors: {
    origin: "*", // Có thể thay bằng domain Flutter nếu cần bảo mật
    methods: ["GET", "POST"]
  },
  allowEIO3: true // ✅ Cho phép client Socket.IO v2 (Flutter) kết nối
});

// ✅ API test
app.get("/", (req, res) => {
  res.send("✅ Socket.IO server is running");
});

// ✅ Lắng nghe kết nối từ client
io.on("connection", (socket) => {
  const now = new Date().toLocaleString();
  console.log(`[${now}] ✅ New user connected: ${socket.id}`);

  // Gửi thông điệp chào mừng
  socket.emit("message", {
    text: "Welcome to the Socket.IO server!",
    time: new Date().toISOString()
  });

  // Nhận message từ client
  socket.on("chat_message", (msg) => {
    const timestamp = new Date().toISOString();
    console.log(`[${timestamp}] 📩 Message from ${socket.id}: ${msg}`);

    // Phát lại cho tất cả client
    io.emit("chat_message", {
      sender: socket.id,
      text: msg,
      time: timestamp
    });
  });

  // Ngắt kết nối
  socket.on("disconnect", () => {
    const disconnectTime = new Date().toLocaleString();
    console.log(`[${disconnectTime}] ❌ User disconnected: ${socket.id}`);
  });
});

server.listen(port, "0.0.0.0", () => {
  console.log(`✅ Server is running on port ${port}`);
});
