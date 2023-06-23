FactoryBot.define do
  factory :telegram_response, class: String do
    skip_create

    initialize_with do
      new(
        {
          "ok": true,
          "result": {
            "message_id": 123,
            "from": {
              "id": 1234567890,
              "is_bot": true,
              "first_name": "something",
              "username": "some_user_name"
            },
            "chat": {
              "id": 987654321,
              "title": "some_title",
              "type": "group",
              "all_members_are_administrators": true
            },
            "date": 1687547003,
            "text": "test"
          }
        }.to_json
      )
    end
  end
end
