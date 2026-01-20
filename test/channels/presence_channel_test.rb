require "test_helper"

class PresenceChannelTest < ActionCable::Channel::TestCase
  def setup
    @user = create(:user)
  end

  test "should subscribe to presence channel" do
    subscribe

    assert subscription.confirmed?
    assert_has_stream "presence"
  end

  test "should broadcast status updates" do
    subscribe

    status = create(:status, :out)
    user = create(:user)

    assert_broadcasts "presence", 1 do
      ActionCable.server.broadcast("presence", {
        type: "status_update",
        user: {
          id: user.id,
          name: user.name,
          status: {
            id: status.id,
            label: status.label,
            color_code: status.color_code,
            icon: status.icon
          }
        }
      })
    end
  end

  test "should receive broadcast messages" do
    subscribe

    perform_enqueued_jobs do
      ActionCable.server.broadcast("presence", {
        type: "status_update",
        user: { id: 1, name: "Test" }
      })
    end

    assert_broadcast_on "presence", { type: "status_update", user: { id: 1, name: "Test" } }
  end
end
