transform.ga.addMediumCategories <- function(d) {
	d %>%
    mutate(medium_cat = ifelse(grepl('organic', medium, ignore.case = TRUE), 'Organic', medium),
           medium_cat = ifelse(grepl('email|klaviyo|sms|push|box|weekly', medium, ignore.case = TRUE), 'Marketing Automation', medium_cat),
           medium_cat = ifelse(grepl('social|facebook|instagram|linkedin|post', medium, ignore.case = TRUE), 'Social', medium_cat),
           medium_cat = ifelse(grepl('cpc|advert|ppc|cpm|sponsored|display|dispay', medium, ignore.case = TRUE), 'Media', medium_cat),
           medium_cat = ifelse(grepl('blog|content|hampers|news|providoor|button', medium, ignore.case = TRUE), 'Content', medium_cat),
           medium_cat = ifelse(grepl('none|not set|others', medium, ignore.case = TRUE), 'None', medium_cat),
           medium_cat = ifelse(grepl('web|landing-page|discover|referral|website|button|afterpay|share', medium, ignore.case = TRUE), 'Referral', medium_cat))
}
