const mongoose = require('mongoose');

const chatSchema = new mongoose.Schema({
    members: [{
        type: mongoose.Schema.ObjectId,
        ref: 'User',
    }],
    
}) 

chatSchema.pre(/^find/, function(next) {
    this.populate({
        path: 'members',
        select: 'name photo shop'
    })

    next();
})

module.exports = mongoose.model('Chat', chatSchema);