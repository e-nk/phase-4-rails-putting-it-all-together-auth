class RecipesController < ApplicationController

    def index
      if session[:user_id]
        @recipes = Recipe.all 
        render json: @recipes, status: :created
      else
        render json: { errors: ["You are not logged in"] }, status: :unauthorized
      end
    end
  
    def create
      if session[:user_id]
        @user = User.find(session[:user_id])
        @recipe = @user.recipes.new(recipe_params)
        if @recipe.valid?
          @recipe.save!
          render json: @recipe, status: :created
        else
          render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: ["You are not logged in"] }, status: :unauthorized
      end
    end
  
    private
  
    def recipe_params
      params.permit(:title, :instructions, :minutes_to_complete)
    end
end