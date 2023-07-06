require 'json'

class PharmacyManagementSystem
  def initialize
    @drug_inventory = {}
  end

  def add_drug
    puts "Enter drug name: "
    name = gets.chomp
    puts "Enter price: "
    price = gets.chomp.to_f
    puts "Enter quantity: "
    quantity = gets.chomp.to_i

    @drug_inventory[name] = { 'price' => price, 'quantity' => quantity }

    puts "Drug added successfully!"
  end

  def update_drug
    puts "Enter drug name: "
    name = gets.chomp

    if @drug_inventory.key?(name)
      puts "Enter new price: "
      price = gets.chomp.to_f
      puts "Enter new quantity: "
      quantity = gets.chomp.to_i

      @drug_inventory[name]['price'] = price
      @drug_inventory[name]['quantity'] = quantity

      puts "Drug information updated successfully!"
    else
      puts "Drug not found in the inventory!"
    end
  end

  def view_drug
    puts "Enter drug name (leave blank to view all drugs): "
    name = gets.chomp

    if name.empty?
      if @drug_inventory.empty?
        puts "No drugs in the inventory!"
      else
        @drug_inventory.each do |drug, info|
          puts "Drug Name: #{drug}"
          puts "Price: #{info['price']}"
          puts "Quantity: #{info['quantity']}"
        end
      end
    else
      if @drug_inventory.key?(name)
        puts "Drug Name: #{name}"
        puts "Price: #{@drug_inventory[name]['price']}"
        puts "Quantity: #{@drug_inventory[name]['quantity']}"
      else
        puts "Drug not found in the inventory!"
      end
    end
  end

  def record_purchase
    puts "Enter drug name: "
    name = gets.chomp

    if @drug_inventory.key?(name)
      puts "Enter quantity purchased: "
      quantity = gets.chomp.to_i

      if quantity <= @drug_inventory[name]['quantity']
        @drug_inventory[name]['quantity'] -= quantity
        puts "Purchase recorded successfully!"
      else
        puts "Insufficient quantity in the inventory!"
      end
    else
      puts "Drug not found in the inventory!"
    end
  end

  def search_drug
    puts "Enter a keyword to search for drugs: "
    keyword = gets.chomp.downcase

    search_results = @drug_inventory.keys.select { |drug| drug.downcase.include?(keyword) }

    if search_results.empty?
      puts "No drugs found matching the keyword."
    else
      puts "Search Results:"
      search_results.each { |result| puts result }
    end
  end

  def delete_drug
    puts "Enter drug name to delete: "
    name = gets.chomp

    if @drug_inventory.key?(name)
      @drug_inventory.delete(name)
      puts "#{name} deleted from the inventory."
    else
      puts "Drug not found in the inventory!"
    end
  end

  def set_expiration_date
    puts "Enter drug name: "
    name = gets.chomp

    if @drug_inventory.key?(name)
      puts "Enter expiration date (YYYY-MM-DD): "
      expiration_date = gets.chomp

      @drug_inventory[name]['expiration_date'] = expiration_date

      puts "Expiration date set successfully!"
    else
      puts "Drug not found in the inventory!"
    end
  end

  def check_low_stock_alert
    puts "Enter the minimum quantity threshold: "
    threshold = gets.chomp.to_i    low_stock_drugs = @drug_inventory.select { |_, info| info['quantity'] <= threshold }.keys

    if low_stock_drugs.empty?
      puts "No drugs are below the quantity threshold."
    else
      puts "Low Stock Drugs:"
      low_stock_drugs.each { |drug| puts drug }
    end
  end

  def generate_sales_report
    total_sales = 0.0

    @drug_inventory.each do |drug, info|
      price = info['price']
      quantity_sold = info['quantity'] - @drug_inventory[drug]['quantity']
      total_sales += price * quantity_sold
    end

    puts "Total Sales: $#{format('%.2f', total_sales)}"

    sorted_drugs = @drug_inventory.sort_by { |_, info| info['quantity'] }.reverse

    puts "Top Selling Drugs:"
    sorted_drugs.first(5).each do |drug, info|
      quantity_sold = info['quantity'] - @drug_inventory[drug]['quantity']
      puts "Drug Name: #{drug}"
      puts "Quantity Sold: #{quantity_sold}"
    end
  end

  def user_authentication
    puts "Enter username: "
    username = gets.chomp
    puts "Enter password: "
    password = gets.chomp

    if username == 'admin' && password == 'password'
      puts "Authentication successful. Access granted."
    else
      puts "Authentication failed. Access denied."
    end
  end

  def save_data
    File.open("drug_inventory.json", "w") do |file|
      file.write(JSON.generate(@drug_inventory))
    end

    puts "Data saved successfully."
  end

  def load_data
    if File.exist?("drug_inventory.json")
      json_data = File.read("drug_inventory.json")
      @drug_inventory = JSON.parse(json_data)

      puts "Data loaded successfully."
    else
      puts "No previous data found."
    end
  end

  def menu
    loop do
      puts "\nPharmacy Management System"
      puts "1. Add Drug"
      puts "2. Update Drug Information"
      puts "3. View Drug Information"
      puts "4. Record Purchase"
      puts "5. Search Drug"
      puts "6. Delete Drug"
      puts "7. Set Expiration Date"
      puts "8. Check Low Stock Alert"
      puts "9. Generate Sales Report"
      puts "10. User Authentication"
      puts "11. Save Data"
      puts "12. Load Data"
      puts "13. Quit"

      print "Enter your choice: "
      choice = gets.chomp

      case choice
      when "1"
        add_drug
      when "2"
        update_drug
      when "3"
        view_drug
      when "4"
        record_purchase
      when "5"
        search_drug
      when "6"
        delete_drug
      when "7"
        set_expiration_date
      when "8"
        check_low_stock_alert
      when "9"
        generate_sales_report
      when "10"
        user_authentication
      when "11"
        save_data
      when "12"
        load_data
      when "13"
        break
      else
        puts "Invalid choice. Try again!"
      end
    end
  end
end

pharmacy_management_system = PharmacyManagementSystem.new
pharmacy_management_system.menu
