require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player = players(:one)
    @original_api_token = ENV["API_TOKEN"]
    ENV["API_TOKEN"] = "test-api-token"
    @auth = { "Authorization" => "Bearer test-api-token" }
  end

  teardown do
    ENV["API_TOKEN"] = @original_api_token
  end

  test "should get index" do
    get players_url, as: :json
    assert_response :success
  end

  test "should create player" do
    assert_difference("Player.count") do
      post players_url, params: { player: { fflogs_Id: @player.fflogs_Id, name: @player.name, server: @player.server } }, headers: @auth, as: :json
    end

    assert_response :created
  end

  test "should show player" do
    get player_url(@player), as: :json
    assert_response :success
  end

  test "should update player" do
    patch player_url(@player), params: { player: { fflogs_Id: @player.fflogs_Id, name: @player.name, server: @player.server } }, headers: @auth, as: :json
    assert_response :success
  end

  test "should destroy player" do
    assert_difference("Player.count", -1) do
      delete player_url(@player), headers: @auth, as: :json
    end

    assert_response :no_content
  end

  test "should not create player without api token" do
    assert_no_difference("Player.count") do
      post players_url, params: { player: { fflogs_Id: @player.fflogs_Id, name: @player.name, server: @player.server } }, as: :json
    end

    assert_response :unauthorized
  end

  test "should not update player without api token" do
    patch player_url(@player), params: { player: { name: "changed" } }, as: :json

    assert_response :unauthorized
    assert_equal "MyString", @player.reload.name
  end

  test "should not destroy player without api token" do
    assert_no_difference("Player.count") do
      delete player_url(@player), as: :json
    end

    assert_response :unauthorized
  end

  test "should not destroy player with wrong api token" do
    assert_no_difference("Player.count") do
      delete player_url(@player), headers: { "Authorization" => "Bearer wrong-token" }, as: :json
    end

    assert_response :unauthorized
  end

  test "should refuse writes when API_TOKEN is not configured" do
    ENV.delete("API_TOKEN")

    assert_no_difference("Player.count") do
      delete player_url(@player), headers: { "Authorization" => "Bearer " }, as: :json
      delete player_url(@player), headers: @auth, as: :json
    end

    assert_response :unauthorized
  end
end
