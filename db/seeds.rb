# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Trip.destroy_all
User.destroy_all
Item.destroy_all
Friendship.destroy_all

users = User.create([
  
    {
        name: "Bob",
        email: "bob@mail.com",
        password: "bob"
    },
    {
        name: "Chris",
        email: "chris@mail.com",
        password: "chris"
    },
    {
        name: "Dave",
        email: "dave@mail.com",
        password: "dave"

    }
])

friendships = Friendship.create([
    
    {
        owner: users[0],
        friend: users[1],
        pending: true
    }, 
    {
        owner: users[0],
        friend: users[2],
        pending: true
    } 
])

trips = Trip.create([
  
    {
        name: "Big Bear",
        description: "We going to big bear b*tches",
        user_ids: [users[0].id, users[1].id, users[2].id]
    },
    {
        name: "Palm Springs",
        description: "Coachella Weekend 1",
        user_ids: [users[1].id, users[2].id, users[0].id]
    } 
])

items = Item.create([

    {
        name: "House",
        price: 2000,
        user_id: users[0].id,
        trip_id: trips[1].id
    },
    {
        name: "Food",
        price: 400,
        user_id: users[1].id,
        trip_id: trips[1].id
    },
    {
        name: "Goodies",
        price: 500,
        user_id: users[2].id,
        trip_id: trips[1].id
    },
    {
        name: "Cabin",
        price: 1000,
        user_id: users[2].id,
        trip_id: trips[0].id
    },
    {
        name: "Alcohol",
        price: 300,
        user_id: users[1].id,
        trip_id: trips[0].id
    },
    {
        name: "Food",
        price: 250,
        user_id: users[0].id,
        trip_id: trips[0].id
    }
])
