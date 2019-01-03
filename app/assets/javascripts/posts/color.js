var $li = $('#links-list li').click(function () {
    $li.removeClass('selected');
    $(this).addClass('selected');
});