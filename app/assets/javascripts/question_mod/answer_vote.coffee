class AnswerVote
  constructor: (@$elm)->
    @question_id = jQuery(".page-question-show .question .vote").data "question-id"
    @bind_event()

  bind_event: ->
    @$elm.on "click", "a.vote-up", (evt)=>
      @to_vote("vote_up")

    @$elm.on "click", "a.vote-down", (evt)=>
      @to_vote("vote_down")

  to_vote: (vote_type)->
    @answer_id = jQuery(event.target).closest(".vote").data "answer-id"
    $up_btn = jQuery(event.target).closest(".vote").find "a.vote-up"
    $down_btn = jQuery(event.target).closest(".vote").find "a.vote-down"
    $unvoted = jQuery(event.target).closest(".answer").find ".unvoted"
    $voted = jQuery(event.target).closest(".answer").find ".voted"
    $vote_sum = jQuery(event.target).closest(".vote").find ".vote-sum"
    $up_sum = jQuery(event.target).closest(".answer").find ".answer-vote .count"
    up_sum_before_vote = jQuery(event.target).closest(".answer").find(".answer-vote .voted .count").text()
    jQuery.ajax
      method: "PUT"
      url: "/questions/#{@question_id}/answers/#{@answer_id}/"+ vote_type 
      type: "json"
      success: (info)=>
        @change_by_info1(info,$up_btn,$down_btn,$vote_sum)
        @change_by_info2(info,$unvoted,$voted,$up_sum,up_sum_before_vote)

  change_by_info1: (info,$up_btn,$down_btn,$vote_sum)-> 
    if info.state == "up"
      $up_btn.addClass "pressed"
      $down_btn.removeClass "pressed"

    if info.state == "down"
      $up_btn.removeClass "pressed"
      $down_btn.addClass "pressed"

    if info.state == null
      $up_btn.removeClass "pressed"
      $down_btn.removeClass "pressed"
      
    $vote_sum.text(info.vote_sum)
    
  
  change_by_info2: (info,$unvoted,$voted,$up_sum,up_sum_before_vote)->
    if info.up_sum - up_sum_before_vote != 0
      $unvoted.toggleClass "hidden"
      $voted.toggleClass "hidden"

    $up_sum.text(info.up_sum)

jQuery(document).on 'page:change', ->
  if jQuery(".page-question-show .answer .vote").length > 0
    new AnswerVote(jQuery(".page-question-show .answer .vote"))

  if jQuery(".page-question-show .answer-vote").length > 0
    new AnswerVote(jQuery(".page-question-show .answer-vote"))