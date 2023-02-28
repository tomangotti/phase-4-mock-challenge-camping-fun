class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        campers = Camper.all 
        render json: campers, include: ['activites', 'signups'], status: :ok
    end

    def show
        camper = Camper.all.find(params[:id])
        render json: camper, status: :ok
    end

    def create
        camper = Camper.create!(post_params)
        render json: camper, status: :created
        rescue ActiveRecord::RecordInvalid => e
            render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    private 

    def render_not_found_response
        render json: {error: "Camper not found"}, status: :not_found
    end

    def post_params
        params.permit(:name, :age, :id)
    end
end
