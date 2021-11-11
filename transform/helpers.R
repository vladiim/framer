transform.normVarNames <- function(d) {
  names(d) <- tolower(names(d))
  names(d) <- gsub('\\.|\\s', '_', names(d))
  names(d) <- gsub('\\(|\\)', '', names(d))
  names(d) <- gsub('__|___', '_', names(d))
  names(d) <- gsub('_$', '', names(d))
  d
}

transform.helpers.mobiEnrich <- function(d) {
  service_map <- load.helpers.serviceMap()
  d %>%
    mutate(visit_date   = as.Date(visit_date, '%d/%m/%Y'),
           when_cancelled = as.Date(when_cancelled, '%Y-%m-%d'),
           visit_month  = as.Date(format(visit_date, '%Y-%m-1')),
           booking_date = as.Date(booking_date, '%d/%m/%Y'),
           booking_month  = as.Date(format(booking_date, '%Y-%m-1')),
           channel      = ifelse(inbound == 1, 'Outbound', 'Inbound'),
           channel      = ifelse(online_booking == 'True', 'Online', channel),
           experiment = str_extract(metadata, 'EID\\d{2}_(Test|Control)'),
           cancelled = grepl('CANCEL', status),
           experiment = str_extract(metadata, 'EID\\d{2}_(Test|Control)'),
           service = service_map$service[match(visit_type, service_map$visit_type)],
           new_patient = grepl('NP', service),
           revenue_service = !grepl(NON_REVENUE_VISIT_TYPES_REGEX, visit_type))
}

transform.helpers.mobiSelect <- function(d) {
  d %>%
    dplyr::select(global_id, country, visit_reason, visit_type, visit_cost, booking_date, visit_date, status, when_status_changed, promo_code, cancellation_reason, when_cancelled, metadata, visit_month, booking_month, channel, revenue_service)
}

helpers.incrementMonth <- function(original_date, months) {
  d        <- as.Date(original_date)
  month(d) <- month(d) + months
  d
}

transform.age <- function(dob, age.day = today(), units = "years", floor = TRUE) {
    calc.age = interval(dob, age.day) / duration(num = 1, units = units)
    if (floor) return(as.integer(floor(calc.age)))
    return(calc.age)
}
