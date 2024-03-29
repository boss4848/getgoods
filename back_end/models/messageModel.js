const mongoose = require('mongoose');

const messageSchema = new mongoose.Schema({
    chatId : {
        type : mongoose.Schema.ObjectId,
        ref : 'Chat',
        require : [true, 'Room ID should have']
    },
    message : {
        type : String,
        require : [true, 'Message should have']
    },
    sender : {
        type : mongoose.Schema.ObjectId,
        ref : "User",
        require : [true, 'Sender should have']
    },

},{
    timestamps : true
},this.collection = 'messages') 

module.exports = mongoose.model('Message', messageSchema);