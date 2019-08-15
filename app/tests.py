import unittest
import identidock


class TestCase(unittest.TestCase):
    def setUp(self):
        """
        инициализация тестовой версии с использованием сервера Flask
        """
        identidock.app.config["TESTING"] = True
        self.app = identidock.app.test_client()

    def test_get_mainpage(self):
        """
        тестирование вызова URL /
        проверка успешного возврата кода ответа, проверка полученных данных на строки 'Hello', Margaret Hamilton'
        """
        page = self.app.post("/", data=dict(name='Margaret Hamilton'))
        assert page.status_code == 200
        assert 'Hello' in str(page.data)
        assert 'Margaret Hamilton' in str(page.data)

    def test_html_escaping(self):
        """
        проверка правильности экранирования HTML-элементов в потоке ввода
        """
        page = self.app.post("/", data=dict(name='"><b>TEST</b><!--"'))
        assert '<b>' not in str(page.data)


if __name__ == '__main__':
    unittest.main()
