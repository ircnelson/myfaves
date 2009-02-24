require 'test_helper'

class FavoritesControllerTest < ActionController::TestCase

  def test_create
    Favorite.any_instance.expects(:save).returns(true)
    post :create, :favorite => { }
    assert_response :redirect
  end

  def test_create_with_failure
    Favorite.any_instance.expects(:save).returns(false)
    post :create, :favorite => { }
    assert_template "new"
  end

  def test_destroy
    Favorite.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => favorites(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  def test_destroy_with_failure
    Favorite.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => favorites(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  def test_edit
    get :edit, :id => favorites(:one).to_param
    assert_response :success
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:favorites)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_show
    get :show, :id => favorites(:one).to_param
    assert_response :success
  end

  def test_update
    Favorite.any_instance.expects(:save).returns(true)
    put :update, :id => favorites(:one).to_param, :favorite => { }
    assert_response :redirect
  end

  def test_update_with_failure
    Favorite.any_instance.expects(:save).returns(false)
    put :update, :id => favorites(:one).to_param, :favorite => { }
    assert_template "edit"
  end

end