<template>
    <div>
       
        <div class="collection">
            <VirtualCollection :cellSizeAndPositionGetter="cellSizeAndPositionGetter" :collection="items" :height="800" :width="width">
                <div slot="cell" slot-scope="props" class="card" ><img :width="props.width" :height="props.height" :src="require('@/assets/imgs/'+props.data.img+'')"></div>
            </VirtualCollection>
        </div>
    </div>
</template>
<style lang="scss">
  
</style>
<script>
    export default {
        computed: {
        items() {
            const amount = +this.amount
            const line = +this.line
            const columnHeight = new Array(line).fill(0)
            return new Array(amount).fill(1).map((_, index) => {
                const column = index % line
                const height = 250 + 200 * Math.random()
                const result = {
                    data: {
                        text: `#${index}`,
                        img:this.imgArr[index]
                    },
                    height,
                    width: 75,
                    x: column * 500,
                    y: columnHeight[column]
                }
                columnHeight[column] += height + 100
                return result
            })
        }
    },
        data () {
          return {
        
            imgArr:["7.png","2.jpg","4.png","6.png","11.png","8.png","9.png","10.png","3.png", "5.png","1.jpg"],
            amount: "11",
            line: "3",
            width: (document.body.clientWidth || document.documentElement.clientWidth) - 20
        }
        },
        methods: {
           cellSizeAndPositionGetter(item) {
         
            return  item
        },
        randomColor() {
            return "color" + parseInt(Math.random() * 8)
        }
        }
    }
</script>