# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# industries = ["Transport Operations", "Transport Structural Repair and Refinishing", "Transport Systems Diagnostics and Service", "Public Safety", "Emergency Response", "Legal Practices", "Marketing",
#   "Professional Sales", "Entrepreneurship/Self-Employment", "Marketing", "Professional Sales",  "Entrepreneurship/Self-Employment", "Information Technology", "Software and Systems Development", "Games and Simulation", "Food Science, Dietetics, and Nutrition",
#   "Food Service and Hospitality", "Hospitality, Tourism, and Recreation", "Biotechnology",
#   "Patient Care", "Healthcare Administrative Services", "Healthcare Operational Support Services",
#   "Public and Community Health", "Mental and Behavioral Health", "Fashion Design, and Merchandising",
#   "Interior Design, Furnishings, and Maintenance", "Personal Services", "Architectural Design",
#   "Engineering Technology", "Engineering Design", "Environmental Engineering", "Energy and Power Technology", "Environmental Resources", "Telecommunications", "Child Development",
#   "Consumer Services", "Education", "Family and Human Services",
#   "Business Management", "Financial Services", "International Business",
#   "Cabinetry, Millwork, and Woodworking", "Engineering and Heavy Construction",
#   "Mechanical Systems Installation and Repair", "Residential and Commercial Construction",
#   "Design, Visual, and Media Arts", "Performing Arts", "Production and Managerial Arts",
#   "Game Design and Integration", "Agriculture and Natural Resources"]


  # industries.each do |industry|
  #   Industry.create(name: industry)
  # end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?