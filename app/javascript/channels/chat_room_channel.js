import consumer from "./consumer"

// チャットルームのIDを動的に取得する方法を用意
const chatRoomId = document.querySelector("#chat-room-id").value;

consumer.subscriptions.create({ channel: "ChatRoomChannel", chat_room_id: chatRoomId }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // チャットメッセージを表示する処理をここに記述
  }
});
