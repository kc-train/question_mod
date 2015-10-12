class QuestionComment
  constructor: (@$show_comment, @$comment_content)->
    @question_id = @$comment_content.find(".form").data("question-id")
    @bind_event()

  bind_event: ->
    @$show_comment.on "click", =>
      @$comment_content.toggleClass "hidden"

    @$comment_content.on "click", ".form a.btn.add-comments", =>

      content = @$comment_content.find(".form textarea").val()
      content = jQuery.trim(content)
      if content == ""
        alert("做一个 textarea 闪动效果")
        return

      jQuery.ajax
        method: "POST"
        url: "/questions/#{@question_id}/comments"
        data:
          "comment[content]": content
        type: "html"
        success: (html)=>
          @$comment_content.find("ul.comments").append(html)

jQuery(document).on 'page:change', ->
  $show_comment = jQuery(".page-question-show .question .show-comment")
  $comment_content = jQuery(".page-question-show .question .comment-content")

  if $show_comment.length > 0 && $comment_content.length > 0
    new QuestionComment $show_comment, $comment_content
