from selenium import webdriver
from selenium.webdriver.common.by import By
import time

# Indicate the paths to the brower binary and driver
brave_binary = "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"
chromedriver = "chromedriver"

# Setting the browser up
driver_options = webdriver.ChromeOptions()
driver_options.binary_location = brave_binary

# Setting up the download path (if appropriate)
driver_options.add_experimental_option(
"prefs", {"download.default_directory": output_dir}
)

# Instantiating the browser
driver = webdriver.Chrome(options=driver_options)

# Navigating
driver.get("http://huanglab.phys.hust.edu.cn/hpepdock/")

# Submitting a file via XPATH
file_input = driver.find_element(By.XPATH, "//input[@<id/name>='<SOMETHING>']")
file_input.send_keys("<PATH TO FILE>")

# Filling out an input by ID
peptide_sequences_input = driver.find_element(By.ID, "<SOME ELEMENT ID>")
peptide_sequences_input.send_keys("<SOMETHING TO INPUT>")

# Submitting a form/Clicking a button
submit_button = driver.find_element(By.NAME, "upload")
submit_button.click()

# Downloading a file (just click on the link)
download_link.click()

# Getting the current URL
current_url = driver.current_url

# Closing the browser
driver.close()
