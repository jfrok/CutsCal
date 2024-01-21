<template>

    <apexchart width="100%" type="bar" :options="chartOptions" :series="series" />
</template>

<script>
export default {
    props:{
        p:Array,
        count:Array,
        eventCount:Array,
        clientCount:Array,
    },
    data() {
        return {
            series: [
                {
                    color:'#ff9900',
                    name: 'Planed Orders',
                    data: this.eventCount,
                },
                {
                    name: 'Registered Clients',
                    data: this.clientCount,
                },
                // {
                //     name: 'Free Cash Flow',
                //     data: [35, 41, 36, 26, 45, 48, 52, 53, 41],
                // },
            ],
            chartOptions: {
                chart: {
                    type: 'bar',
                    height: 350,
                },
                plotOptions: {
                    bar: {
                        horizontal: false,
                        columnWidth: '55%',
                        endingShape: 'rounded',
                    },
                },
                dataLabels: {
                    enabled: false,
                },
                stroke: {
                    show: true,
                    width: 2,
                    colors: ['transparent'],
                },
                xaxis: {
                    categories: this.p,
                },
                yaxis: {
                    title: {
                        text: 'Overview',
                    },
                },
                fill: {
                    opacity: 1,
                },
                tooltip: {
                    y: {
                        formatter: function (val) {
                            return val;
                        },
                    },
                },
            },
        };
    },
};
</script>
