const mongoose = require('mongoose');
const dotenv = require('dotenv');
const app = require('./app');
const http = require('http');
const socketIO = require('socket.io');
const Message = require('./models/messageModel')

//Handle uncaught exceptions
process.on('uncaughtException', err => {
    console.log(err.name, err.message);
    console.log('UNCAUGHT EXCEPTION! Shutting down...');
    process.exit(1);
});

dotenv.config({ path: './config.env' });
const DB = process.env.DATABASE.replace(
    '<PASSWORD>',
    process.env.DATABASE_PASSWORD
);

mongoose.connect(DB, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    dbName: 'getgoods',
}).then(() => {
    console.log('DB connection successful!')
});

const port = process.env.PORT || 3000;
const server = http.createServer(app);
const io = socketIO(server);

// Socket.IO integration
io.on('connection', (socket) => {
    const userName = socket.handshake.query.userName;
    // const chatId = socket.handshake.query.chatId;

    console.log('A user connected');
    console.log('username: ' + userName);

    socket.on('chat message', (message) => {
        console.log('chatId: '+ message.chatId);

        Message.create({
            chatId : message.chatId,
            message : message.message,
            sender : userName
        });
        console.log('Message received:', message);
        io.emit('chat message', message);
    });

    socket.on('disconnect', () => {
        console.log('A user disconnected');
    });
});

server.listen(port, () => {
    console.log(`App running on port ${port}...`);
});
// app.listen(port, () => {
//     console.log(`App running on port ${port}...`);
// });

//Handle unhandled rejections
process.on('unhandledRejection', err => {
    console.log(err.name, err.message);
    console.log('UNHANDLED REJECTION! Shutting down...');
    server.close(() => {
        process.exit(1);
    });
});

