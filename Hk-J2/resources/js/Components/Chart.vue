<template>
    <div>
        <apexchart width="100%" type="line" :options="options" :series="series"/>
    </div>
</template>
<script>

export default {
    props:{
        p:Array,
        count:Array,
        eventCount:Array,
    },
    data: function() {
        return {
            options: {
                chart: {
                    id: 'Activities'
                },
                xaxis: {
                    categories: this.p
                }
            },
            series: [
                //     {
                //     name: 'projects',
                //     data: this.count,
                // },
                {
                    name: 'events',
                    data: this.eventCount
                }]
        }
    }
}
</script>
