class User
  attr_accessor :name, :email, :password, :rooms

  def initialize(name, email, password)
    @name = name
    @email = email
    @password = password
    @rooms = []
  end

  def enter_room(room)
    unless @rooms.include?(room)
      @rooms << room
      room.add_user(self)
      puts "#{name} has entered the room: #{room.name}"
    end
  end

  def send_message(room, content)
    if @rooms.include?(room)
      message = Message.new(self, room, content)
      room.broadcast(message)
    else
      puts "You need to enter the room first."
    end
  end
 
  def acknowledge_message(room, message)
    if @rooms.include?(room)
      puts "#{name} acknowledges the message: '#{message.content}' from #{message.user.name}"
    else
      puts "#{name}, you can't acknowledge the message because you are not in this room."
    end
  end
end

class Room
  attr_accessor :name, :description, :users

  def initialize(name, description)
    @name = name
    @description = description
    @users = []
  end

  def add_user(user)
    @users << user unless @users.include?(user)
  end

  def broadcast(message)
    puts "Message from #{message.user.name} in room #{name}: #{message.content}"
    @users.each do |user|
      next if user == message.user 
      user.acknowledge_message(self, message)
    end
  end
end

class Message
  attr_accessor :user, :room, :content

  def initialize(user, room, content)
    @user = user
    @room = room
    @content = content
  end
end


user1 = User.new("AAA", "AAA@123.com", "123")
user2 = User.new("BBB", "BBB@456.com", "456")
user3 = User.new("CCC", "CCC@789.com","789")

room1 = Room.new("Room1", "First Room")


user1.enter_room(room1)
user2.enter_room(room1)


user1.send_message(room1, "Hello everyone")
user3.acknowledge_message(room1, Message.new("Alice", room1, "Hello every one "))
user2.send_message(room1, "Hey Alice")