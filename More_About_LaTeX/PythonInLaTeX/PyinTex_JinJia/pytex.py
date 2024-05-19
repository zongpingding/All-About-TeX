from jinja2 import Template
import sys
import datetime
import locale
import time,locale

# 解决time库无法识别中文的问题
timestr="2020-10-10 10:10:10"
t=time.strptime(timestr,"%Y-%m-%d %H:%M:%S")
locale.setlocale(locale.LC_CTYPE,'chinese')

#  定义的方法必须只返回字符串
class Settings:
    coding = 'utf8'
    inc = {}

    @classmethod
    def getinc(cls, name, st=1, isauto=True):
        num = cls.inc.get(name, st)
        if isauto:
            cls.inc[name] = num + 1
        return num
    
    @classmethod
    def today(cls, fmstr='%Y年%m月%d日'):
        dt = datetime.datetime.now()
        return dt.strftime(fmstr)

    @classmethod
    def num2cn(cls, _string='', isbig=False):
        tb = str.maketrans('0123456789', '零壹贰叁肆伍陆柒捌玖'
                            if isbig else '〇一二三四五六七八九')
        return _string.translate(tb)

    @classmethod
    def loop(cls, num, str):
        ls = ''
        for i in range(1, num):
             ls = ls + str + " "
        return ls

    @classmethod
    def IsPrime(self, num):
        flag = 1
        string = ''
        for i in range(2,int(num)):
            if num%i == 0: 
                flag = 0
                break
        if flag == 0:
            string = str(num) + '是合数'
            return string
        else:
            string = str(num) + '是素数'
            return string


if __name__ == '__main__':
    fname = sys.argv[1]
    tex = open(fname, 'r', encoding=Settings.coding).read()
    tmptex = Template(tex).render(st=Settings)
    sys.stdout.write(tmptex)
    with open(fname.replace('.tex', '.ptex'), 'w', encoding=Settings.coding) as f:
        f.write(tmptex)