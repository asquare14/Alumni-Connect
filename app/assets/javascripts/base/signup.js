$(document).on('turbolinks:load', function () {

    // when a post is clicked, show its full content in a modal window
    $(".school-student-dropdown").change(function () {
        var val = $(this).val();
        console.log(val);
        if (val === "Yes") {
            $('.school-field').show();
            $('.institute-field').hide();

        }
        else {
            $('.school-field').hide();
            $('.institute-field').show();
        }
    });
});