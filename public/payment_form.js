$(function () {
    payment_form = $('form').attr('id');
    addLinkToSetDefaults();
});


function setDefaultsForAll() {
         if (payment_form === "payment_confirmation"){
      setDefaultsForUnsignedDetailsSection();
   }
   else {
      setDefaultsForPaymentDetailsSection();
   }
}

function addLinkToSetDefaults() {
    $(".section").prev().each(function (i) {
        legendText = $(this).text();
        $(this).text("");

        let setDefaultMethod = "setDefaultsFor" + capitalize($(this).next().attr("id")) + "()";

        newlink = $(document.createElement("a"));
        newlink.attr({
            id:'link-' + i, name:'link' + i, href:'#'
        });
        newlink.append(document.createTextNode(legendText));
        newlink.bind('click', function () {
            eval(setDefaultMethod);
        });

        $(this).append(newlink);
    });

    newbutton = $(document.createElement("input"));
    newbutton.attr({
        id:'defaultAll', value:'Default All', type:'button', onClick:'setDefaultsForAll()'
    });
    newbutton.bind('click', function() {
        setDefaultsForAll;
    });
    $("#"+payment_form).append(newbutton);
}

function capitalize(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function setDefaultsForPaymentDetailsSection() {
    $("input[name='reference_number']").val(new Date().getTime());
    $("input[name='amount']").val("1.00");
    $("input[name='currency']").val("VND");

    if ($('#payment_tokenization').length > 0) {
        $("input[name='transaction_type']").val("authorization");
        $("input[name='payment_token']").val("Paste your payment token here");
    } else {
        $("input[name='transaction_type']").val("sale,create_payment_token");
        $("input[name='payment_method']").val("card");
        $("input[name='bill_to_forename']").val("John");
        $("input[name='bill_to_surname']").val("Doe");
        $("input[name='bill_to_email']").val("test@cybersource.com");
        $("input[name='bill_to_phone']").val("02890888888");
        $("input[name='bill_to_address_line1']").val("1 Card Lane");
        $("input[name='bill_to_address_city']").val("My City");
        $("input[name='bill_to_address_state']").val("CA");
        $("input[name='bill_to_address_country']").val("US");
        $("input[name='bill_to_address_postal_code']").val("94043");
    }
}

function setDefaultsForUnsignedDetailsSection(){
    $("input[name='card_type']").val("001");
    $("input[name='card_number']").val("4000000000000002");
    $("input[name='card_expiry_date']").val("01-2022");
}
