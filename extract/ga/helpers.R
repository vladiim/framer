create_variable_segment <- function(variable, operator, dim = 'pagePath'){
	se <- create_segment_element(variable, operator, dim)
  sd <- define_segment(se)
  segment_ga4(paste0(dim, ": ", variable), session_segment = sd)
}

create_segment_element <- function(variable, operator, dim = 'pagePath') {
  segment_element(dim, operator = operator, type = "DIMENSION", expression = variable)
}

define_segment <- function(segment_elements) {
  sv <- segment_vector_simple(list(list(se)))
  segment_define(list(sv))
}
