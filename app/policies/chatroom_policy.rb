class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    # TODO: make sure that this chatroom can only be accessed by those who have the rights for it
    true
  end
end
