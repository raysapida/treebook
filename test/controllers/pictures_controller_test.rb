require 'test_helper'

class PicturesControllerTest < ActionController::TestCase
  setup do
    @picture = pictures(:one)
		@album = albums(:vacation)
		@user = users(:jason)
		@default_params = { profile_name: @user.profile_name, album_id: @album.id }
  end

  test "should get index" do
    get :index, @default_params
    assert_response :success
    assert_not_nil assigns(:pictures)
  end

  test "should get new" do
		sign_in users(:jason)
    get :new, @default_params
    assert_response :success
  end

  test "should create picture" do
		sign_in users(:jason)
    assert_difference('Picture.count') do
      post :create, @default_params.merge(picture: { album_id: @picture.album_id, caption: @picture.caption, description: @picture.description, user_id: @picture.user_id })
    end

    assert_redirected_to album_pictures_path(assigns(:album))
  end

  test "should show picture" do
    get :show, @default_params.merge(id: @picture)
    assert_response :success
  end

  test "should get edit" do
		sign_in users(:jason)
    get :edit, @default_params.merge(id: @picture)
    assert_response :success
  end

  test "should update picture" do
		sign_in users(:jason)
    patch :update, @default_params.merge(id: @picture, picture: { album_id: @picture.album_id, caption: @picture.caption, description: @picture.description, user_id: @picture.user_id })
    assert_redirected_to album_pictures_path(assigns(:album))
  end

  test "should destroy picture" do
		sign_in users(:jason)
    assert_difference('Picture.count', -1) do
      delete :destroy, @default_params.merge(id: @picture)
    end

    assert_redirected_to album_pictures_path
  end
end
