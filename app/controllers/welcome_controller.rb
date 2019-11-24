require 'assigner'

class WelcomeController < ApplicationController
  def index
  end

  def pair
    flash[:notice] = "Pair successfully"
    Assigner.assign_and_save(Member.all)
    redirect_to :root
  end

  def rollback
    if PairHistory.rollback!
      flash[:notice] = "Rollback successfully"
    else
      flash[:alert] = "No history for rollback"
    end

    redirect_to :root
  end
end
