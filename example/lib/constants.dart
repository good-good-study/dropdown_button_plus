/// Option,对账单
const filterOption = <String>[''];

/// 综合排序
const filterSort = <String>[
  '销量最高',
  '距离优先',
  '速度优先',
  '好评优先',
  '起送价最低',
  '配送最快',
  '配送费最低',
  '人均从低到高',
  '人均从高到低',
  '通用排序',
];

/// Status,商家特色
const filterStatus = <String>[
  '新上架',
  '0元起送',
  '跨天预定',
  '开发票',
  '优选商家',
  '赠准时宝',
  '放心吃',
  '极速退款',
];

const menuOptions = [
  '快捷筛选',
  '收入',
  '支出',
  '本人资金往来',
  '金额',
  '理财',
  '往来',
  '借贷',
  '其他',
];

const menuValues = <String, List<String>>{
  '快捷筛选': ['全部收入', '全部支出', '薪酬', '他人转入', '转账给他人', '全部往来'],
  '收入': ['全部收入', '全部支出', '薪酬', '他人转入', '转账给他人', '全部往来'],
  '支出': ['全部支出', '红包', '购物', '餐饮', '还款', '转账给他人', '出行', '其他支出', '生活日用'],
  '本人资金往来': ['全部往来', '转账给自己', '理财产品', '基金', '贵金属', '还招行信用卡'],
  '金额': [
    '0-100',
    '100-500',
    '500-2000',
    '2000-5000',
    '5000-10000',
    '10000-15000',
    '15000-20000'
  ],
  '理财': ['存款', '理财产品', '保险', '基金证券', '利息分红', '外汇贵金属', '其他投资'],
  '往来': ['外币', '红包', '转账', '现金', '退款'],
  '借贷': ['信用卡透支', '其他借贷'],
  '其他': ['其他'],
};
