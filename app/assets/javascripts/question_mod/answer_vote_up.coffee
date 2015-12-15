class @AnswerVoteUp
  constructor: (@$elm)->
    @question_id = jQuery(".page-question-show .question .vote").data "question-id"
    @bind_event()

  bind_event: ->
    @$elm.on "click", ".voted", (evt)=>
      @to_vote_up()

    @$elm.on "click", ".unvoted", (evt)=>
      @to_vote_up()

  to_vote_up: ->
    @answer_id = jQuery(event.target).closest(".answer-vote-up").data "id"
    $unvoted = jQuery(event.target).closest(".answer-vote-up").find ".unvoted"
    $voted = jQuery(event.target).closest(".answer-vote-up").find ".voted"
    $up_sum = jQuery(event.target).closest(".answer-vote-up").find ".count"
    up_sum_before_vote = jQuery(event.target).find(".count").text()
    $up_btn = jQuery(event.target).closest(".answer").find "a.vote-up"
    $down_btn = jQuery(event.target).closest(".answer").find "a.vote-down"
    $vote_sum = jQuery(event.target).closest(".answer").find ".vote-sum"
    jQuery.ajax
      method: "PUT"
      url: "/questions/#{@question_id}/answers/#{@answer_id}/vote_up"
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
    $unvoted.toggleClass "hidden"
    $voted.toggleClass "hidden"
    $up_sum.text(info.up_sum)

jQuery(document).on 'page:change', ->
  if jQuery(".page-question-show .answer-vote-up").length > 0
    new AnswerVoteUp(jQuery(".page-question-show .answer-vote-up"))
