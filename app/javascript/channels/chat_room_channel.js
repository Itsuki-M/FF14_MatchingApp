import consumer from "./consumer"
const path = window.location.pathname;
const ROOM_ID = path.split("/").pop();

const chatRoom = consumer.subscriptions.create({channel: "ChatRoomChannel", chat_room_id: ROOM_ID, user_id: currentUserId}, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const messages = document.getElementById('messages');
    let messageHTML
    if(data.user_id.toString() == currentUserId){
      messageHTML = data.message;
    }else{
      messageHTML = data.second_message;
    }
    messages.insertAdjacentHTML('beforeend', messageHTML);
  },

  speak: function(message) {
    return this.perform('speak', { message: message });
  }
});

window.addEventListener("keypress", function(event) {
  if (event.key === 'Enter') {
    chatRoom.speak(event.target.value);
    event.target.value = '';
    event.preventDefault();
  }
});
