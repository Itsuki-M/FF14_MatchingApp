import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const chatRoomElement = document.getElementById('chat-room');
  if (chatRoomElement) {
    const chatRoomId = chatRoomElement.getAttribute('data-chat-room-id');
    const chatRoomChannel = consumer.subscriptions.create({ channel: "ChatRoomChannel", chat_room_id: chatRoomId }, {
      connected() {
        // 接続時の処理
      },

      disconnected() {
        // 切断時の処理
      },

      received(data) {
        const messagesElement = document.getElementById('messages');
        if (messagesElement) {
          // 受信したメッセージをmessages要素に追加
          messagesElement.innerHTML += data.message;
        }
      }
    });

    // メッセージ送信フォームのイベントリスナー
    const formElement = document.getElementById('new_message');
    if (formElement) {
      formElement.addEventListener('submit', function(e) {
        e.preventDefault();
        const messageInput = formElement.querySelector('#message');
        const message = messageInput.value;

        // ActionCableを通じてメッセージを送信
        chatRoomChannel.perform('speak', { message: message });

        // メッセージ入力欄をクリア
        messageInput.value = '';
      });
    }
  }
});
