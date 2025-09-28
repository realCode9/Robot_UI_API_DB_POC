from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn


@library
class FirstClass:

    def __init__(self):
        self.selLib = BuiltIn().get_library_instance("SeleniumLibrary")

    @keyword("First Custom Keyword")
    def first_def_keyword(self):
        print("Hello this is first keyword")

    @keyword
    def select_item_to_add_to_cart(self, cssElementTexts, productsListToSelect):
        elements = self.selLib.get_webelements(cssElementTexts)
        print(elements)
        index = 1
        print(index)
        for element in elements:
            print(element.text)
            if element.text in productsListToSelect:
                print("element exist in the list 1" + element.text)
                print("xpath:(//a[text() ='Add to basket'])["+str(index)+"]")
                self.selLib.wait_until_element_is_visible("xpath:(//div[@class='card-footer']//button)["+str(index)+"]")
                print("element exist in the list 2" + element.text)
                self.selLib.scroll_element_into_view("xpath:(//div[@class='card-footer']//button)["+str(index)+"]")
                print("element exist in the list 3" + element.text)
                self.selLib.click_button("xpath:(//div[@class='card-footer']//button)["+str(index)+"]")
                print("element exist in the list 4" + element.text)
            index= index+1