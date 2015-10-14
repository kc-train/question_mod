class AnswerComment
  constructor: (@$show_comment, @$comment_content)->
    @question_id = jQuery(".page-question-show .question .comment-content .form").data("question-id")
    @bind_event()

  bind_event: ->
    @$show_comment.on "click", =>
      $comment_content = jQuery(event.target).closest(".answer").find(".comment-content") 
      $comment_content.toggleClass "hidden"

    @$comment_content.on "click", ".form a.btn.add-comments", =>
      @answer_id = jQuery(event.target).closest(".form").data("answer-id")
      content = jQuery(event.target).closest(".form").find("textarea").val()
      content = jQuery.trim(content)
      $comments = jQuery(event.target).closest(".answer").find("ul.comments")
      if content == ""
        alert("做一个 textarea 闪动效果")
        return

      jQuery.ajax
        method: "POST"
        url: "/questions/#{@question_id}/answers/#{@answer_id}/comments"
        data:
          "comment[content]": content
        type: "html"
        success: (html)=>
          $comments.append(html)

    @$comment_content.on "click", "ul.comments a.reply", =>
      jQuery(event.target).closest(".comment").find(".comment-form").toggleClass "hidden"

    @$comment_content.on "click", "ul.comments a.cancel", =>
      jQuery(event.target).closest(".comment").find(".comment-form").toggleClass "hidden"

    @$comment_content.on "click", "ul.comments a.add-comments", =>
      @answer_id = jQuery(event.target).closest(".answer").find(".vote").data("answer-id")
      $comment_form = jQuery(event.target).closest(".comment-form")
      $comments = jQuery(event.target).closest(".answer").find("ul.comments")
      content =jQuery(event.target).closest(".comment").find(".comment-form textarea").val()
      content = jQuery.trim(content)
      reply_comment_id = jQuery(event.target).closest(".comment-form").data("comment-id")
      if content == ""
        alert("做一个 textarea 闪动效果")
        return

      jQuery.ajax
        method: "POST"
        url: "/questions/#{@question_id}/answers/#{@answer_id}/comments"
        data:
          "comment[content]": content,
          "comment[reply_comment_id]": reply_comment_id
        type: "html"
        success: (html)=>
          $comment_form.remove()
          $comments.append(html)

    @$comment_content.on "click", "ul.comments a.delete", =>
      @answer_id = jQuery(event.target).closest(".answer").find(".vote").data("answer-id")
      @comment_id = jQuery(event.target).closest(".comment").data("comment-id")
      $comment_content = jQuery(event.target).closest(".comment")
      jQuery.ajax
        method: "DELETE"
        url: "/questions/#{@question_id}/answers/#{@answer_id}/comments/#{@comment_id}"
        success: ()=>
          $comment_content.remove()

jQuery(document).on 'page:change', ->
  $show_comment = jQuery(".page-question-show .answer .show-comment")
  $comment_content = jQuery(".page-question-show .answer .comment-content")

  if $show_comment.length > 0 && $comment_content.length > 0
    new AnswerComment $show_comment, $comment_content