require 'test_helper'

class SectionsControllerTest < ActionController::TestCase

  def test_create
    Section.any_instance.expects(:save).returns(true)
    post :create, :section => { }
    assert_response :redirect
  end

  def test_create_with_failure
    Section.any_instance.expects(:save).returns(false)
    post :create, :section => { }
    assert_template "new"
  end

  def test_destroy
    Section.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => sections(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  def test_destroy_with_failure
    Section.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => sections(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  def test_edit
    get :edit, :id => sections(:one).to_param
    assert_response :success
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:sections)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_show
    get :show, :id => sections(:one).to_param
    assert_response :success
  end

  def test_update
    Section.any_instance.expects(:save).returns(true)
    put :update, :id => sections(:one).to_param, :section => { }
    assert_response :redirect
  end

  def test_update_with_failure
    Section.any_instance.expects(:save).returns(false)
    put :update, :id => sections(:one).to_param, :section => { }
    assert_template "edit"
  end

end