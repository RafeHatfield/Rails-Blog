require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :all
  
  test "multiple users creating an article" do
    eugene = registered_user
    lauren = registered_user
    
    eugene.logs_in 'eugene@example.com', 'secret'
    lauren.logs_in 'lauren@example.com', 'secret'
    
    eugene.creates_article :title => 'Integration tests', :body => 'Lorem Ipsum..'
    lauren.creates_article :title => 'Open Session', :body => 'lorem ipsum..'
    
    eugene.logs_out
    lauren.logs_out
  end
  
  private
    def registered_user
      open_session do |user|
        def user.logs_in(email, password)
          get login_path
          
          assert_response :success
          assert_template 'new'
          
          post session_path, :email => email, :password => password
          
          assert_response :redirect
          assert_redirected_to root_path
          
          follow_redirect!
          
          assert_response :success
          assert_template 'index'
          assert session[:user_id]
        end
        
        def user.logs_out
          get logout_path
          
          assert_response :redirect
          assert_redirected_to root_path
          assert_nil session[:user]
          
          follow_redirect!
          
          assert_template 'index'
        end
        
        def user.creates_article(article_hash)
          get new_article_path
          
          assert_response :success
          assert_template 'new'
          
          post articles_path, :article => article_hash
          
          assert assigns(:article).valid?
          assert_response :redirect
          assert_redirected_to article_path(assigns(:article))
          
          follow_redirect!
          
          assert_response :success
          assert_template 'show'
        end
      end
    end
  # 
  # test "should login and create article and logout" do
  #   #Login
  #   get login_path
  #   
  #   assert_response :success
  #   assert_template 'new'
  #   
  #   post session_path, :email => 'eugene@example.com', :password => 'secret'
  #   
  #   assert_response :redirect
  #   assert_redirected_to root_path
  #   
  #   follow_redirect!
  #   
  #   assert_response :success
  #   assert_template 'index'
  #   assert session[:user_id]
  #   
  #   #Create New Article
  #   get new_article_path
  #   
  #   assert_response :success
  #   assert_template 'new'
  #   
  #   post articles_path, :article => {:title => 'Integration Tests', :body => 'Lorem Ipsum..'}
  #   
  #   assert assigns(:article).valid?
  #   assert_response :redirect
  #   assert_redirected_to article_path(assigns(:article))
  #   
  #   follow_redirect!
  #   
  #   assert_response :success
  #   assert_template 'show'
  #   
  #   #Logout
  #   get logout_path
  #   
  #   assert_response :redirect
  #   assert_redirected_to root_path
  #   assert_nil session[:user]
  #   
  #   follow_redirect!
  #   
  #   assert_template 'index'
  # end
  # 
  # test "should login user and redirect" do
  #   get login_path
  #   
  #   assert_response :success
  #   assert_template 'new'
  #   
  #   post session_path, :email => 'eugene@example.com', :password => 'secret'
  #   
  #   assert_response :redirect
  #   assert_redirected_to root_path
  #   
  #   follow_redirect!
  #   
  #   assert_response :success
  #   assert_template 'index'
  #   assert session[:user_id]
  # end
  # 
  # test "should logout user and redirect" do
  #     get logout_path
  #     
  #     assert_response :redirect
  #     assert_redirected_to root_path
  #     assert_nil session[:user]
  #     
  #     follow_redirect!
  #     
  #     assert_template 'index'
  # end
  
end
