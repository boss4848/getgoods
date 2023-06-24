const mongoose = require('mongoose');

const chatSchema = new mongoose.Schema({
    member : {
        type : Array,
        default : []
    },
    
}) 

module.exports = mongoose.model('Chat', chatSchema);