
$(document).ready(function(){
  $("table.clist").on("click", "td input", function() {
    checklistId = $(this).attr('id')
    
      console.log('checked'); 
      var tripId = $('#trip').attr('value')
      var checked = ($('#' + checklistId).prop('checked')) === true ? true : false
      console.log(checked);
      dataString = { add_checklist: checked, tripId: tripId } 
      
      $.ajax({
        type: "PUT",
        url: "/checklists/" + checklistId,
        beforeSend: function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")},
        data: dataString,
        dataType: "html",
        success: function(data, textStatus){
          console.log(data)
          $('#' + 'checked-by' + checklistId).html(data)
        }
      })
  });
});
