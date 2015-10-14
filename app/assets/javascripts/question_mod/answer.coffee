class Answer
  constructor: (@$answer)->
    @question_id = jQuery(".page-question-show .question .comment-content .form").data("question-id")
    @answer_id = @$answer.find(".update-form").data("answer-id")
    @bind_event()

  bind_event: =>
    @$answer.on "click", ".edit", =>
      jQuery(event.target).toggleClass "hidden"
      jQuery(event.target).closest(".answer").find(".content").toggleClass "hidden"
      jQuery(event.target).closest(".answer").find(".update-form").toggleClass "hidden"

    @$answer.on "click", ".update-form .update-cancel", =>
      jQuery(event.target).closest(".answer").find(".edit").toggleClass "hidden"
      jQuery(event.target).closest(".answer").find(".content").toggleClass "hidden"
      jQuery(event.target).closest(".answer").find(".update-form").toggleClass "hidden"

    @$answer.on "click", ".update-form .update-answer", =>
      console.log @answer_id
      content = @$answer.find(".update-form textarea").val()
      content = jQuery.trim(content)
      $content = jQuery(event.target).closest(".answer").find(".content")
      $eidt = jQuery(event.target).closest(".answer").find(".edit")
      $update_form = jQuery(event.target).closest(".answer").find(".update-form")
      if content == ""
        alert("做一个 textarea 闪动效果")
        return

      jQuery.ajax
        method: "PATCH"
        url: "/questions/#{@question_id}/answers/#{@answer_id}"
        data:
          "answer[content]": content
        type: "html"
        success: (html)=>
          $content.text(content)
          $content.toggleClass "hidden"
          $eidt.toggleClass "hidden"
          $update_form.toggleClass "hidden"
          

jQuery(document).on "page:change",->
  $answer = jQuery(".page-question-show .answer")

  if $answer.length > 0
    new Answer $answer
