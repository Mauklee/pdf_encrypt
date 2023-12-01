variable "project" {
  description = "Project Name"
  type        = string
  default     = "pdf_encrypt"
}

variable "Owner" {
  description = "The owner of the resources"
  type        = string
  default     = "Abdulmalik Lawal"
}

variable "no_of_availability_zones" {
  description = "The number of availability zones to use"
  type        = number
  default     = 3
}
