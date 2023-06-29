const mongoose = require('mongoose');

const chatSchema = new mongoose.Schema({
    members: [{
        user: {
            type: mongoose.Schema.ObjectId,
            ref: 'User'
        },
        shop: {
            type: mongoose.Schema.ObjectId,
            ref: 'User'
        }
    }]
    
}) 

chatSchema.pre(/^find/, function(next) {
    this.populate({
        path: 'members.user',
        select: 'name photo shop'
    }).populate({
        path: 'members.shop',
        select: 'name photo shop'
    })
    //populate shop name
    // .populate({
    //     path: 'members.shop',
    //     select: 'name'
    // })
    // .populate({
    //     path: 'members.shop.owner',
    //     select: 'name'
    // })
    next();
});


// chatSchema.pre(/^find/, function(next) {
//     this.populate({
//         path: 'users',
//         select: 'name photo'
//     }).populate({
//         path: 'shops',
//         select: 'name owner'
//     })

//     next();
// })

module.exports = mongoose.model('Chat', chatSchema);