module Helpers

  def create_post(caption: caption)
    visit "/"
    click_on "new post"
    attach_file("post[image]", "spec/files/images/avo-toast.jpg")
    fill_in "post[caption]", with: caption
    click_on "Create Post"
  end

  def delete_post
    click_on "delete"
  end

end