
class InstanceAccessService
  def self.deployments
    result = []
    arr = [
      {

        id: 1,
        site_name: 'www1.test.com',
        status: {
          level: 'success',
          message: 'deployed'
        },
        date: 'Feb. 20, 2020'
      },
      {
        id: 2,
        site_name: 'www1.test.com',
        status: {
          level: 'success',
          message: 'deployed'
        },
        date: 'Feb. 18, 2020'
      },
      {
        id: 2,
        site_name: 'www1.test.com',
        status: {
          level: 'critical',
          message: 'failed'
        },
        date: 'Feb. 18, 2020'
      }
    ]

    arr.each do |item|
      result << OpenStruct.new(item)
    end

    result
  end

  def self.activity_stream
    result = []
    arr = [
      {
        id: 1,
        user: 'Gaston',
        message: 'Did something',
        status: {
          level: 'success',
          message: 'deployed'
        },
        date: 'Feb. 20, 2020'
      },
      {
        id: 2,
        user: 'Martin',
        message: 'Deployed a website',
        status: {
          level: 'success',
          message: 'deployed'
        },
        date: 'Feb. 18, 2020'
      },
      {
        id: 3,
        user: 'Arnold',
        message: 'Deleted a website',
        status: {
          level: 'success',
          message: 'deployed'
        },
        date: 'Feb. 18, 2020'
      }
    ]

    arr.each do |item|
      result << OpenStruct.new(item)
    end

    result
  end

  def self.spending_chart_data
    {
      "2020-02-01": 11,
      "2020-02-02": 6,
      "2020-02-03": 23,
      "2020-02-10": 12,
      "2020-02-12": 90,
      "2020-02-18": 4
    }
  end

  def self.spending_costs
    [
      {
        id: 12,
        date: '2020-02-01',
        credits: 90,
        cost: 140
      },
      {
        id: 16,
        date: '2020-02-02',
        credits: 490,
        cost: 120
      }
    ]
  end

  def self.logs
  end
end
