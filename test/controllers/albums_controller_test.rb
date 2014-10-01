require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  setup do
    @album = albums(:vacation)
		@user = users(:jason)
  end

  test "should get index" do
    get :index, profile_name: @user.profile_name
    assert_response :success
    assert_not_nil assigns(:albums)
  end

  test "should get new" do
		sign_in users(:jason)
    get :new, profile_name: @user.profile_name
    assert_response :success
  end

  test "should create album" do
		sign_in users(:jason)
    assert_difference('Album.count') do
      post :create, profile_name: @user.profile_name, album: { title: @album.title, user_id: @album.user_id }
    end

    assert_redirected_to album_path(assigns(:album))
  end

  test "should show album" do
    get :show, id: @album, profile_name: @user.profile_name
    assert_response :redirect
		assert_redirected_to album_pictures_path(@user.profile_name, @album.id)
  end

  test "should get edit" do
		sign_in users(:jason)
    get :edit, id: @album, profile_name: @user.profile_name
    assert_response :success
  end

  test "should update album" do
		sign_in users(:jason)
    patch :update, profile_name: @user.profile_name, id: @album, album: { title: @album.title, user_id: @album.user_id }
    assert_redirected_to album_pictures_path(@user.profile_name, @album.id)
  end

  test "should destroy album" do
		sign_in users(:jason)
    assert_difference('Album.count', -1) do
      delete :destroy, id: @album, profile_name: @user.profile_name
    end

    assert_redirected_to albums_path
  end
end
